using Tenant.Infra.Models.Owner;
using WMInfra.Response;

namespace Tenant.Domain.Interfaces
{
    public interface IOwnerProcessor
    {
        Response<Guid?> InsertRoomDetails(Room room);
        Response<int?> InsertTransactionDetails(TransactionDetails transactionDetails);

        Response<List<OwnerDashboard>?> GetAllRoomsOfTenant();
        Response<OwnerRoomDetails?> GetRoomDetailsByRoomId(Guid roomId);
    }
}
