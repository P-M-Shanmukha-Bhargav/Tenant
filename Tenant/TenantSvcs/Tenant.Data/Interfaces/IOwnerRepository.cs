using Tenant.Infra.Models.Owner;

namespace Tenant.Data.Interfaces
{
    public interface IOwnerRepository
    {
        Guid? InsertRoomDetails(Room room);
        int? InsertRoomAddress(RoomAddress roomAddress);
        int? InsertTransactionDetails(TransactionDetails transactionDetails);

        List<OwnerDashboard>? GetAllRoomsOfTenant();
        OwnerRoomDetails? GetRoomDetailsByRoomId(Guid roomId);

        bool? UpdateRoomDetailsByRoomId(OwnerRoomData room);
    }
}
