using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Tenant
{
    public class TransactionHistory
    {
        public string Month { get; set; }
        public int Year { get; set; }
        public bool Active { get; set; }
    }
}
