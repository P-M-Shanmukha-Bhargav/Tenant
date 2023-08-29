using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Instances
{
    public static class UserContext
    {
        private static IHttpContextAccessor _httpContextAccessor = new HttpContextAccessor();

        public static string GetUserId
        {
            get
            {
                var instance = _httpContextAccessor.HttpContext.Request.Headers;
                return instance["uid"];
            }
        }
    }
}
