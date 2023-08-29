using CustomerModels.Models;
using CustomerModels.Models.User;
using CustomerModels.Models.User.Register;
using CustomerModels.Models.User.Response;

namespace CustomerData.Interfaces
{
    public interface IUserData
    {
        int InsertUserData(RegisterUser user);
        User GetUserDetailsByEmail(string emailId, string password);
        int InsertUserRefreshToken(AuthResponse auth);
        LoginDetails GetUserDetailsByRefreshToken(AuthResponse auth);
        EmailMobileExists IsEmailOrMobileNumberExist(string mobileNumber, string emailId);
    }
}
