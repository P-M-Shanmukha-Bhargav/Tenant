using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tenant.Data.Interfaces;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Models.Owner;
using Tenant.Infra.Models.Tenant;
using WMInfra.Response;

namespace Tenant.Domain
{
    public class OwnerProcessor: IOwnerProcessor
    {
        private readonly IOwnerRepository _ownerRepository;
        public OwnerProcessor(IOwnerRepository ownerRepository)
        {
            _ownerRepository = ownerRepository;
        }

        public Response<List<OwnerDashboard>?> GetAllRoomsOfTenant()
        {
            var resp = _ownerRepository.GetAllRoomsOfTenant();
            return resp != null ? new Response<List<OwnerDashboard>?>(resp)
                : new Response<List<OwnerDashboard>?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<OwnerRoomDetails?> GetRoomDetailsByRoomId(Guid roomId)
        {
            var resp = _ownerRepository.GetRoomDetailsByRoomId(roomId);
            return resp != null ? new Response<OwnerRoomDetails?>(resp)
                : new Response<OwnerRoomDetails?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<Guid?> InsertRoomDetails(Room roomDetails)
        {
            var resp = _ownerRepository.InsertRoomDetails(roomDetails);

            var resp1 = _ownerRepository.InsertRoomAddress(roomDetails.RoomAddress);

            return resp != null ? new Response<Guid?>(resp) :
                new Response<Guid?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<int?> InsertTransactionDetails(TransactionDetails transactionDetails)
        {
            var resp = _ownerRepository.InsertTransactionDetails(transactionDetails);
            return resp != null ? new Response<int?>(resp) :
                new Response<int?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }
    }
}
