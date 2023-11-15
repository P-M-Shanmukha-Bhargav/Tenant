using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tenant.Infra.Enums;

namespace Tenant.Infra.Models.Payment
{
    public class UpdateTenantStatus
    {
        public PaymentStatus paymentStatus { get; set; }
        public string month { get; set; }
        public int year { get; set; }
        public decimal pendingAmount { get; set; }
    }
}
