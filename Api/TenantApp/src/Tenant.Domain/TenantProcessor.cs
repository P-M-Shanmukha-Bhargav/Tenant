using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System.Globalization;
using System.Security.Cryptography;
using Tenant.Data.Interfaces;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Enums;
using Tenant.Infra.Models.Payment;
using Tenant.Infra.Models.Tenant;
using WMInfra.Response;

namespace Tenant.Domain
{
    public class TenantProcessor : ITenantProcessor
    {
        private readonly ITenantRepository _tenantRepository;
        public TenantProcessor(ITenantRepository tenantRepository)
        {
            _tenantRepository = tenantRepository;
        }

        public Response<TenantDashboard?> GetTenantDashboard()
        {
            var currentMonthYear = $"{DateTime.Now:MMM}-{DateTime.Now.Year}";
            var resp = _tenantRepository.GetTenantTransactionByMonthYear(currentMonthYear);
            return resp != null ? new Response<TenantDashboard?>(resp) :
                new Response<TenantDashboard?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<TenantDashboard?> GetTenantTransactionByMonthYear(string monthYear)
        {
            var resp = _tenantRepository.GetTenantTransactionByMonthYear(monthYear);
            return resp != null ? new Response<TenantDashboard?>(resp) :
                new Response<TenantDashboard?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<List<TransactionHistory>?> GetTenantTransactions()
        {
            var resp = _tenantRepository.GetTransactionsByTenantId();
            resp = resp
                .OrderByDescending(x => DateTime.ParseExact(x.Month, "MMM", CultureInfo.InvariantCulture))
                .Select(x => x)
                .ToList();
            return resp.Count > 0 ? new Response<List<TransactionHistory>?>(resp) :
                new Response<List<TransactionHistory>?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<int?> InsertTenantRoomDetails(TenantRoomDetails tenantRoomDetails)
        {
            var resp = _tenantRepository.InsertTenantRoomDetails(tenantRoomDetails);
            return resp != null ? new Response<int?>(resp) :
                new Response<int?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<bool?> UpdateExitDetailsForTenantRoomDetails()
        {
            var resp = _tenantRepository.UpdateExitDetailsForTenantRoomDetails();
            return resp != null ? new Response<bool?>(resp) :
                new Response<bool?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<string> UpdatePaymentTransactionStatus(TenantPaymentResponse data = null)
        {
            var details = data.txnid?.Split(':');

            var userUid = details?.FirstOrDefault();

            var monthYear = details.Skip(1).FirstOrDefault();

            var trxUserDetails = _tenantRepository
                .GetTenantTransactionByMonthYear(monthYear, userUid);

            if (trxUserDetails.IsBillsOwnerControl && 
                (trxUserDetails.PowerAmount > 0 || trxUserDetails.WaterAmount > 0))
            {
                _tenantRepository.UpdateTransactionBillPaymentStatus(PaymentStatus.PAID, $"{DateTime.Now:MMM}", DateTime.Now.Year, data.amount);
            }
            else
            {
                if (data.status == "success")
                {
                    var updated = _tenantRepository.UpdateTransactionBillPaymentStatus(PaymentStatus.PART, $"{DateTime.Now:MMM}", DateTime.Now.Year, data.amount);
                    if (updated.HasValue && updated.Value)
                    {
                        _tenantRepository.InsertTransactionPayment(data);
                    }
                }
                else
                {
                    return new Response<string>("Failed");
                }
            }


            return new Response<string>("Success");
        }

        #region Private Methods
        private static string Sha512String(string input)
        {
            var bytes = System.Text.Encoding.UTF8.GetBytes(input);
            using (var hash = SHA512.Create())
            {
                var hashedInputBytes = hash.ComputeHash(bytes);

                // Convert to text
                // StringBuilder Capacity is 128, because 512 bits / 8 bits in byte * 2 symbols for byte 
                var hashedInputStringBuilder = new System.Text.StringBuilder(128);
                foreach (var b in hashedInputBytes)
                    hashedInputStringBuilder.Append(b.ToString("X2"));
                return hashedInputStringBuilder.ToString();
            }
        }
        #endregion
    }
}
