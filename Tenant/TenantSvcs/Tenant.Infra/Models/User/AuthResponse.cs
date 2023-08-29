﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.User
{
    public class AuthResponse
    {
        public int UserId { get; set; }
        public string AccessToken { get; set; }
        public string RefreshToken { get; set; }
        public DateTime RefreshTokenExpiry { get; set; }
    }
}
