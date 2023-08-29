using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Filters
{
    public class AuthenticateUserAttribute : IAuthorizationFilter
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        public AuthenticateUserAttribute(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public void OnAuthorization(AuthorizationFilterContext context)
        {
            if (!_httpContextAccessor.HttpContext!.Request.Headers["X-Session-Id"].Any())
            {
                context.Result = null;
                return;
            }
        }
    }
}
