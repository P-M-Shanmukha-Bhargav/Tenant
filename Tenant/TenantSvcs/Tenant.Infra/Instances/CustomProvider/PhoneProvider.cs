using Firebase.Auth;
using Firebase.Auth.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Instances.CustomProvider
{
    public class PhoneProvider : FirebaseAuthProvider
    {
        public override FirebaseProviderType ProviderType => FirebaseProviderType.Phone;

        protected override Task<UserCredential> LinkWithCredentialAsync(string idToken, AuthCredential credential)
        {
            throw new NotImplementedException();
        }

        protected override Task<UserCredential> SignInWithCredentialAsync(AuthCredential credential)
        {
            throw new NotImplementedException();
        }
    }
}
