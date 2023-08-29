using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Owner
{
    public class OwnerRoomDetails
    {
        public string TenantUId { get; set; }
        public bool IsAdvancedPaid { get; set; }
        public DateTime RentedOn { get; set; }
        public bool IsRentOpen { get; set; }
        public bool IsForBachelor { get; set; }
        public bool IsOccupied { get; set; }
        public decimal MaintenanceAmount { get; set; }
        public decimal RentAmount { get; set; }
        public int AdvanceMoneyInMonths { get; set; }
    }

    public class OwnerRoomData: OwnerRoomDetails
    {
        public Guid RoomId { get; set; }
    }
}
