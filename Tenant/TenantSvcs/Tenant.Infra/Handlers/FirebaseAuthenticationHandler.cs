using FirebaseAdmin;
using FirebaseAdmin.Auth;
using Google.Cloud.Firestore;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http.Features.Authentication;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;
using System.Threading.Tasks;
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

            if (!Context.Request.Headers.ContainsKey("Authorization"))
                //&& !Context.Request.Headers.ContainsKey("H-UID")
            {
                return AuthenticateResult.NoResult();
            }

            string bearerToken = Context.Request.Headers["Authorization"];

            if(bearerToken == null || !bearerToken.StartsWith("Bearer "))
            {
                return AuthenticateResult.Fail("Invalid Schema");
            }

            try
            {
                var firebaseToken = UserTokenInfo.TokenData(bearerToken);

                var time = DateTimeOffset.FromUnixTimeSeconds(firebaseToken.ExpirationTimeSeconds);

                if (time.LocalDateTime > DateTime.Now.AddMinutes(2))
                {
                    return AuthenticateResult.Success(new AuthenticationTicket(new ClaimsPrincipal(new List<ClaimsIdentity>()
                    {
                        new ClaimsIdentity(ToClaims(firebaseToken.Claims), nameof(FirebaseAuthenticationHandler))
                    }), JwtBearerDefaults.AuthenticationScheme));
                }
                return AuthenticateResult.Fail("Expired");
            }
            catch(Exception ex)
            {
                return AuthenticateResult.Fail(ex);
            }

        }

        private static IEnumerable<Claim> ToClaims(IReadOnlyDictionary<string, object> claims)
        {
            return new List<Claim>()
            {
                new Claim("id", claims["user_id"].ToString()),
                new Claim("email", claims["email"].ToString()),
                //new Claim("phone_number", claims["phone_number"].ToString()),
                //new Claim("name", claims["name"].ToString()),
            };
        }
    }
}
