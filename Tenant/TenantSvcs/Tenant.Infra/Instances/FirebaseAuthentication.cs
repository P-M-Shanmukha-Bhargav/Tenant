using Firebase.Auth.Providers;
using Firebase.Auth;
using FirebaseAdmin.Auth;
using Google.Apis.Auth.OAuth2;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Instances
{
    public class FirebaseAuthentication
    {
        private static FirebaseAuth instance;
        private static FirebaseAuthClient instance2;
        private FirebaseAuthentication()
        {

        }

        public static FirebaseAuth GetFirebaseCreateAuthApp
        {
            get
            {
                if (instance == null)
                {
                    var app = FirebaseAuth.GetAuth(FirebaseApp.GetFirebaseApp);

                    instance = app;
                }
                return instance;
            }
        }
    }
}
