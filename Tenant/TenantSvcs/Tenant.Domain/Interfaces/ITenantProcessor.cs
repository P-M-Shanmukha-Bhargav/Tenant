using Firebase.Auth;
using Tenant.Infra.Models.Tenant;
using WMInfra.Response;

namespace Tenant.Domain.Interfaces
{
    public interface ITenantProcessor
    {
        Response<int?> InsertTenantRoomDetails(TenantRoomDetails tenantRoomDetails);

        Response<TenantDashboard?> GetTenantDashboard();
        Response<List<string>?> GetTenantTransactions();
        Response<TenantDashboard?> GetTenantTransactionByMonthYear(string monthYear);

        Response<bool?> UpdateExitDetailsForTenantRoomDetails();
    }
}
