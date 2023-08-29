using Google.Apis.Auth.OAuth2;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Instances
{
    public class FirebaseDb
    {
        private static Google.Cloud.Firestore.FirestoreDb instance;
        private FirebaseDb()
        {

        }

        public static Google.Cloud.Firestore.FirestoreDb GetFirebaseDbApp
        {
            get
            {
                if (instance == null)
                {
                    var app = new Google.Cloud.Firestore.FirestoreDbBuilder()
                    {
                        GoogleCredential = GoogleCredential.FromJson(FirebaseApp.FirebaseCreds),
                        ProjectId = FirebaseApp.FirebaseProjectId
                    }.Build();

                    instance = app;
                }
                return instance;
            }
        }
    }
}
