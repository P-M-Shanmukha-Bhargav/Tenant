using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Tenant
{
    public class TenantRoomDetails
    {
        public Guid RoomId { get; set; }
        public bool IsAdvancePaid { get; set; }
        public DateTime AdvancePaidDate { get; set; }
        public decimal AdvancePendingAmount { get; set; }
        public int RentPaidDate { get; set; }
        public DateTime RentedOn { get; set; }
    }

    public class TenantRoomDetailsData
    {
        public int TenantRoomDetailsId { get; set; }
        public string TenantUId { get; set; }
    }
}
