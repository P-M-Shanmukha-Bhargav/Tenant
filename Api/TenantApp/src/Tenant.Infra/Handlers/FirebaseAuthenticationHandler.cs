using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text.Encodings.Web;
using Tenant.Infra.Instances;

namespace Tenant.Infra.Handlers
{
    public class FirebaseAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        public FirebaseAuthenticationHandler(IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock) : base(options, logger, encoder, clock)
        {
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {

            if (!Context.Request.Headers.ContainsKey("Authorization")
                && !Context.Request.Headers.ContainsKey("uid"))
            {
                return AuthenticateResult.NoResult();
            }

            string bearerToken = Context.Request.Headers["Authorization"];

            if (bearerToken == null || !bearerToken.StartsWith("Bearer "))
            {
                return AuthenticateResult.Fail("Invalid Schema");
            }

            try
            {
                var handler = new JwtSecurityTokenHandler();
                var token = bearerToken.Substring("Bearer ".Length);
                var firebaseToken = handler.ReadJwtToken(token);

                if (firebaseToken.ValidTo > DateTime.UtcNow.AddMinutes(2))
                {
                    return AuthenticateResult.Success(new AuthenticationTicket(new ClaimsPrincipal(new List<ClaimsIdentity>()
                    {
                        new ClaimsIdentity(firebaseToken.Claims, nameof(FirebaseAuthenticationHandler))
                    }), JwtBearerDefaults.AuthenticationScheme));
                }
                return AuthenticateResult.Fail("Expired");
            }
            catch (Exception ex)
            {
                return AuthenticateResult.Fail(ex);
            }

        }
    }
}
