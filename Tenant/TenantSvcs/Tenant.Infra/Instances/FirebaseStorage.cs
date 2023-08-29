using Google.Apis.Auth.OAuth2;

namespace Tenant.Infra.Instances
{
    public class FirebaseStorage
    {
        private static Google.Cloud.Storage.V1.StorageClient instance;
        private FirebaseStorage()
        {

        }

        public static Google.Cloud.Storage.V1.StorageClient GetFirebaseStorageApp
        {
            get
            {
                if (instance == null)
                {
                    var app = new Google.Cloud.Storage.V1.StorageClientBuilder()
                    {
                        GoogleCredential = GoogleCredential.FromJson(FirebaseApp.FirebaseCreds)
                    }.Build();

                    instance = app;
                }
                return instance;
            }
        }
    }
}
