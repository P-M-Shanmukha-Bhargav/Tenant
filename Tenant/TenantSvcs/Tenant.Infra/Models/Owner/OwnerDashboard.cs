using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Owner
{
    public class OwnerDashboard
    {
        public string TenantUId { get; set; }
        public Guid RoomId { get; set; }
        public string RoomNumber { get; set; }
    }
}
