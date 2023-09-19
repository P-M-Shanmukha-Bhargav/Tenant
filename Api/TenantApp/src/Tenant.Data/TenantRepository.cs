using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using Tenant.Data.Interfaces;
using Tenant.Infra.Enums;
using Tenant.Infra.Extensions;
using Tenant.Infra.Instances;
using Tenant.Infra.Models.Payment;
using Tenant.Infra.Models.Tenant;
using WMInfra.Data;

namespace Tenant.Data
{
    public class TenantRepository : ITenantRepository
    {
        private readonly IConfiguration _configuration;
        private readonly string _userId;
        public TenantRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _userId = UserContext.GetUserId;
        }
        
        public TenantDashboard? GetTenantTransactionByMonthYear(string monthYear, string userUId = null)
        {
            var tenantDetails = new TenantDashboard();
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetSection("Environment").Value)))
            {
                using (var command = connection.CreateCommand("[TRX].[GetTenantTransactionByUIdAndMonthYear_V1]"))
                {
                    command.AddWithValue("@TenantUID", userUId ?? _userId);
                    command.AddWithValue("@BillMonth", monthYear.Split('-').FirstOrDefault());
                    command.AddWithValue("@BillYear", Convert.ToInt32(monthYear.Split('-').LastOrDefault()));

                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            reader.TryGetDecimal("TotalAmount", x => tenantDetails.TotalAmount = x);
                            reader.TryGetDecimal("RentAmount", x => tenantDetails.RentAmount = x);
                            reader.TryGetDecimal("MaintenanceAmount", x => tenantDetails.MaintenanceAmount = x);
                            reader.TryGetDecimal("PowerAmount", x => tenantDetails.PowerAmount = x);
                            reader.TryGetDecimal("WaterAmount", x => tenantDetails.WaterAmount = x);
                            reader.TryGetDecimal("OtherAmount", x => tenantDetails.OtherAmount = x);
                            reader.TryGetDecimal("PendingAmount", x => tenantDetails.PendingAmount = x);
                            reader.TryGetDecimal("AdvancePendingAmount", x => tenantDetails.AdvancePendingAmount = x);
                            reader.TryGetInt32("IsAmountPaid", x => tenantDetails.IsAmountPaid = x > 0);
                            reader.TryGetInt32("IsBillsOwnerControl", x => tenantDetails.IsBillsOwnerControl = x > 0);
                            reader.TryGetString("PaymentStatus", x => tenantDetails.PaymentStatus = x);
                            reader.TryGetString("PaymentType", x => tenantDetails.PaymentType = x);
                            return tenantDetails;
                        }
                    }
                }

            }

            return null;
        }

        public List<TransactionHistory> GetTransactionsByTenantId()
        {
            var monthYear = new List<TransactionHistory>();
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetSection("Environment").Value)))
            {
                using (var command = connection.CreateCommand("[TRX].[GetTenantMonthYearTransactionByUId_V1]"))
                {
                    command.AddWithValue("@TenantUID", _userId);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            monthYear.Add(LoadMonthYearTransactions(reader));
                        }
                    }
                }

            }

            return monthYear;
        }

        public int? InsertTenantRoomDetails(TenantRoomDetails tenantRoomDetails)
        {
            int? tenantRoomDetailsId = null;
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetSection("Environment").Value)))
            {
                using (var command = connection.CreateCommand("[ROM].[InsertTenantRoomDetails_V1]"))
                {
                    SqlParameter outputParameter;
                    command.AddOutParameter("@TenantRoomDetailsId", SqlDbType.Int, out outputParameter);
                    command.AddWithValue("@TenantUId", _userId);
                    command.AddWithValue("@RoomId", tenantRoomDetails.RoomId);
                    command.AddWithValue("@IsAdvancePaid", tenantRoomDetails.IsAdvancePaid);
                    command.AddWithValue("@AdvancePaidDate", tenantRoomDetails.AdvancePaidDate);
                    command.AddWithValue("@AdvancePendingAmount", tenantRoomDetails.AdvancePendingAmount);
                    command.AddWithValue("@RentPaidDate", tenantRoomDetails.RentPaidDate);
                    command.AddWithValue("@RentedOn", tenantRoomDetails.RentedOn);
                    command.AddWithValue("@IsBillsOwnerControl", tenantRoomDetails.IsBillsOwnerControl);
                    command.AddWithValue("@IsActive", 1);
                    command.AddWithValue("@UpdatedBy", "");
                    
                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    var affectedRowsCount = command.ExecuteNonQuery();
                    if (affectedRowsCount > 0)
                    {
                        tenantRoomDetailsId = Convert.ToInt32(outputParameter.Value);
                    }
                }
            }
            return tenantRoomDetailsId;
        }

        public bool? UpdateExitDetailsForTenantRoomDetails()
        {
            bool? resp = null;
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetSection("Environment").Value)))
            {
                using (var command = connection.CreateCommand("[ROM].[UpdateTeantRoomExitDetails_V1]"))
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

        public bool? UpdateTransactionBillPaymentStatus(PaymentStatus paymentStatus, string month, int year, string paidAmount)
        {
            bool? resp = null;
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetSection("Environment").Value)))
            {
                using (var command = connection.CreateCommand("[TRX].[UpdateTeantTransactionBillPaymentStatus_V1]"))
                {
                    command.AddWithValue("@TenantId", _userId);
                    command.AddWithValue("@PaymentStatus", paymentStatus.ToString());
                    command.AddWithValue("@Month", month);
                    command.AddWithValue("@Year", year);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();
                    var affectedRowsCount = command.ExecuteNonQuery();

                    resp = affectedRowsCount > 0;
                }
            }
            return resp;
        }

        public void InsertTransactionPayment(TenantPaymentResponse resp)
        {
            throw new NotImplementedException();
        }

        #region Private Methods
        private static TransactionHistory LoadMonthYearTransactions(IDataReader reader)
        {
            var transaction = new TransactionHistory();

            reader.TryGetString("BillMonth", x => transaction.Month = x);
            reader.TryGetInt32("BillYear", x => transaction.Year = x);

            return transaction;
        }
        #endregion
    }
}
