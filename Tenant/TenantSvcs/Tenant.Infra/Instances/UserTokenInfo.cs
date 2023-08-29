using FirebaseAdmin.Auth;
using Google.Apis.Auth.OAuth2;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authentication;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Tenant.Infra.Handlers;
using Google.Api;

namespace Tenant.Infra.Instances
{
    public class UserTokenInfo
    {
        private static FirebaseToken instance;
        private UserTokenInfo() { }

        public static FirebaseToken TokenData(string bearerToken)
        {
            //if (instance == null)
            //{
                var token = bearerToken.Substring("Bearer ".Length);

                var firebaseToken = FirebaseAuthentication
                    .GetFirebaseCreateAuthApp.VerifyIdTokenAsync(token)
                    .GetAwaiter().GetResult();

                instance = firebaseToken;
            //}
            return instance;
        }

        public static string UserUId
        {
            get
            {
                return instance.Uid;
            }
        }

    }
}
