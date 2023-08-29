using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomerModels.Models.User.Register
{
    public class RegisterUser
    {
        public string DisplayName { get; set; }
        public string EmailId { get; set; }
        public string MobileNumber { get; set; }
        public string Password { get; set; }
        public int UserTypeId { get; set; }
    }
}
