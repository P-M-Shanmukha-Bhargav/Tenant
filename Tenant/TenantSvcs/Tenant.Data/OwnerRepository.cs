using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using System.Data;
using Tenant.Data.Interfaces;
using Tenant.Infra.Models.Owner;
using Tenant.Infra.Models.Tenant;
using WMInfra.Data;
using Google.Type;

namespace Tenant.Data
{
    public class OwnerRepository : IOwnerRepository
    {
        private readonly IConfiguration _configuration;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly string? _userId;
        public OwnerRepository(IConfiguration configuration, IHttpContextAccessor httpContextAccessor)
        {
            _configuration = configuration;
            _httpContextAccessor = httpContextAccessor;
            _userId = _httpContextAccessor.HttpContext?.User.Claims.FirstOrDefault(x => x.Type == "id")?.Value ?? "CdF89x2S5ORXM6n5wJaSlWKUJb13";
        }

        public Guid? InsertRoomDetails(Room room)
        {
            Guid? roomId = Guid.NewGuid();
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetValue<string>("ENV"))))
            {
                using (var command = connection.CreateCommand("[ROM].[InsertRoomDetails_V1]"))
                {
                    command.AddWithValue("@RoomId", roomId);
                    command.AddWithValue("@OwnerUId", _userId);
                    command.AddWithValue("@AdvanceMoneyInMonths", room.AdvanceMoneyInMonths);
                    command.AddWithValue("@IsForBachelor", room.IsForBachelor);
                    command.AddWithValue("@IsRentOpen", room.IsRentOpen);
                    command.AddWithValue("@IsOccupied", room.IsOccupied);
                    command.AddWithValue("@MaintenanceAmount", room.MaintenanceAmount);
                    command.AddWithValue("@RoomNumber", room.RoomNumber);
                    command.AddWithValue("@RentAmount", room.RentAmount);
                    command.AddWithValue("@RoomSize", room.RoomSize);
                    command.AddWithValue("@RoomSizeTypeId", room.RoomSizeTypeId);
                    command.AddWithValue("@RoomTypeId", room.RoomTypeId);                    
                    command.AddWithValue("@IsActive", 1);
                    command.AddWithValue("@UpdatedBy", _userId);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    var affectedRowsCount = command.ExecuteNonQuery();
                    if (affectedRowsCount > 0)
                    {
                        return roomId;
                    }
                }
            }
            return null;
        }

        public int? InsertRoomAddress(RoomAddress roomAddress)
        {
            int? roomAddressId = null;
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetValue<string>("ENV"))))
            {
                using (var command = connection.CreateCommand("[ROM].[InsertRoomAddress_V1]"))
                {
                    SqlParameter outputParameter;
                    command.AddOutParameter("@RoomAddressId", SqlDbType.Int, out outputParameter);
                    command.AddWithValue("@RoomId", roomAddress.RoomId);
                    command.AddWithValue("@Address1", roomAddress.Address1);
                    command.AddWithValue("@Address2", roomAddress.Address2);
                    command.AddWithValue("@Address3", roomAddress.Address3);
                    command.AddWithValue("@City", roomAddress.City);
                    command.AddWithValue("@State", roomAddress.State);
                    command.AddWithValue("@Zip", roomAddress.Zip);
                    command.AddWithValue("@IsActive", 1);
                    command.AddWithValue("@UpdatedBy", _userId);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    var affectedRowsCount = command.ExecuteNonQuery();
                    if (affectedRowsCount > 0)
                    {
                        roomAddressId = Convert.ToInt32(outputParameter.Value);
                    }
                }
            }
            return roomAddressId;
        }

        public int? InsertTransactionDetails(TransactionDetails transactionDetails)
        {
            int? roomId = 0;
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetValue<string>("ENV"))))
            {
                using (var command = connection.CreateCommand("[TRX].[InsertTransactionDetails_V1]"))
                {
                    command.AddWithValue("@TenantUId", transactionDetails.TenantUId);
                    command.AddWithValue("@BillMonth", transactionDetails.BillMonth);
                    command.AddWithValue("@BillYear", transactionDetails.BillYear);
                    command.AddWithValue("@PowerAmount", transactionDetails.PowerAmount);
                    command.AddWithValue("@OtherAmount", transactionDetails.OtherAmount);
                    command.AddWithValue("@WaterAmount", transactionDetails.WaterAmount);
                    command.AddWithValue("@IsActive", 1);
                    command.AddWithValue("@UpdatedBy", _userId);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    var affectedRowsCount = command.ExecuteNonQuery();
                    if (affectedRowsCount > 0)
                    {
                        return roomId;
                    }
                }
            }
            return null;
        }

        public List<OwnerDashboard>? GetAllRoomsOfTenant()
        {
            var tenantList = new List<OwnerDashboard>();
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetValue<string>("ENV"))))
            {
                using (var command = connection.CreateCommand("[ROM].[GetTenantListForOwner_V1]"))
                {
                    command.AddWithValue("@OwnerUId", _userId);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            tenantList.Add(LoadTenantListForOwner(reader));
                        }
                    }
                }
                return null;
            }
        }

        public OwnerRoomDetails? GetRoomDetailsByRoomId(Guid roomId)
        {
            var ownerTenantDetails = new OwnerRoomDetails();
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetValue<string>("ENV"))))
            {
                using (var command = connection.CreateCommand("[ROM].[GetTenantListForOwner_V1]"))
                {
                    command.AddWithValue("@RoomId", roomId);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            reader.TryGetString("TenantUId", x => ownerTenantDetails.TenantUId = x);
                            reader.TryGetBoolean("IsAdvancedPaid", x => ownerTenantDetails.IsAdvancedPaid = x);
                            reader.TryGetDateTime("RentedOn", x => ownerTenantDetails.RentedOn = x);
                            reader.TryGetBoolean("IsRentOpen", x => ownerTenantDetails.IsRentOpen = x);
                            reader.TryGetBoolean("IsForBachelor", x => ownerTenantDetails.IsForBachelor = x);
                            reader.TryGetBoolean("IsOccupied", x => ownerTenantDetails.IsOccupied = x);
                            reader.TryGetDecimal("MaintenanceAmount", x => ownerTenantDetails.MaintenanceAmount = x);
                            reader.TryGetDecimal("RentAmount", x => ownerTenantDetails.RentAmount = x);
                            reader.TryGetInt32("AdvanceMoneyInMonths", x => ownerTenantDetails.AdvanceMoneyInMonths = x);

                            return ownerTenantDetails;
                        }
                    }
                }
                return null;
            }
        }

        public bool? UpdateRoomDetailsByRoomId(OwnerRoomData ownerRoomData)
        {
            bool? resp = null;
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetValue<string>("ENV"))))
            {
                using (var command = connection.CreateCommand("[ROM].[UpdateRoomDetails_V1]"))
                {
                    command.AddWithValue("@TenantId", _userId);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();
                    var affectedRowsCount = command.ExecuteNonQuery();

                    resp = affectedRowsCount > 0;
                }
            }
            return resp;
        }

        #region Private Methods
        private static OwnerDashboard LoadTenantListForOwner(IDataReader reader)
        {
            var dashboard = new OwnerDashboard();

            reader.TryGetString("TenantUId", x => dashboard.TenantUId = x);
            reader.TryGetGuid("RoomId", x => dashboard.RoomId = x);
            reader.TryGetString("RoomNumber", x => dashboard.RoomNumber = x);

            return dashboard;
        }
        #endregion
    }
}
