using Firebase.Auth;
using Google.Apis.Auth.OAuth2;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Instances
{
    public class FirebaseApp
    {
        private static FirebaseAdmin.FirebaseApp instance;
        private FirebaseApp()
        {

        }

        public static string FirebaseProjectId
        {
            get { return "tenantapp-dev"; }
        }

        public static string FirebaseWebAPIKey
        {
            get { return "AIzaSyClPZIpVrV7XkXwJ1dUSyEMuGTa_gkEpws"; }
        }

        public static string FirebaseAuthDomain
        {
            get { return "tenantapp-dev.firebaseapp.com"; }
        }

        public static string FirebaseConfigUrl
        {
            get
            {
                return "https://firebasestorage.googleapis.com/v0/b/tenantapp-dev.appspot.com/o/tenantapp-dev.json?alt=media&token=6372876f-d204-479c-9443-b21e8dc6bf0b";
            }
        }

        public static string FirebaseCreds
        {
            get
            {
                return new HttpClient().GetStringAsync(FirebaseConfigUrl).GetAwaiter().GetResult();
            }
        }

        public static FirebaseAdmin.FirebaseApp GetFirebaseApp
        {
            get
            {
                if (instance == null)
                {
                    var app = FirebaseAdmin.FirebaseApp.Create(new FirebaseAdmin.AppOptions()
                    {
                        Credential = GoogleCredential.FromJson(FirebaseCreds),
                        ProjectId = FirebaseProjectId
                    });

                    instance = app;
                }
                return instance;
            }
        }
    }
}
