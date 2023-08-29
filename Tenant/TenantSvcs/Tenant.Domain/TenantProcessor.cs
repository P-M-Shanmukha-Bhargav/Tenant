using Firebase.Auth;
using FirebaseAdmin.Auth;
using Google.Cloud.Firestore;
using Microsoft.AspNetCore.Http;
using Tenant.Data.Interfaces;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Instances;
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
                new Response<TenantDashboard?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() {  } });
        }

        public Response<List<string>?> GetTenantTransactions()
        {
            var resp = _tenantRepository.GetTenantTransactionsByTenantUId();
            return resp.Count > 0 ? new Response<List<string>?>(resp) :
                new Response<List<string>?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
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
    }
}
