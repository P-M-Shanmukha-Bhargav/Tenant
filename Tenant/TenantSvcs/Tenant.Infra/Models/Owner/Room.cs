using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Owner
{
    public class Room
    {
        public Room()
        {
            RoomAddress = new RoomAddress();
        }

        public int AdvanceMoneyInMonths { get; set; }
        public bool IsForBachelor { get; set; }
        public bool IsRentOpen { get; set; }
        public bool IsOccupied { get; set; }
        public decimal MaintenanceAmount { get; set; }
        public string RoomNumber { get; set; }
        public decimal RentAmount { get; set; }
        public int RoomSize { get; set; }
        public int RoomSizeTypeId { get; set; }
        public int RoomTypeId { get; set; }
        public RoomAddress RoomAddress { get; set; }
    }
    public class RoomDetails : Room
    {
        public Guid RoomId { get; set; }
        public string OwnerUId { get; set; }
    }
}
