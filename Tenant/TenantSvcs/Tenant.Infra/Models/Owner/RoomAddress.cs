using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Owner
{
    public class RoomAddress
    {
        public Guid RoomId { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string Address3 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
    }

    public class RoomAddressDetails: RoomAddress
    {
        public int RoomAddressId { get; set; }
    }
}
