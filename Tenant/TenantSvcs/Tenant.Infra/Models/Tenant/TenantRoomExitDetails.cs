using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Tenant
{
    public class TenantRoomExitDetails
    {
        public DateTime ExitRequestedOn { get; set; }
        public bool ExitApproved { get; set; }
    }
}
