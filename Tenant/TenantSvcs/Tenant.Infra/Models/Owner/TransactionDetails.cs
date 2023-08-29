using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Owner
{
    public class TransactionDetails
    {
        public string TenantUId { get; set; }
        public decimal PowerAmount { get; set; }
        public decimal WaterAmount { get; set; }
        public decimal OtherAmount { get; set; }
        public string BillMonth { get; set; }
        public int BillYear { get; set; }
    }
}
