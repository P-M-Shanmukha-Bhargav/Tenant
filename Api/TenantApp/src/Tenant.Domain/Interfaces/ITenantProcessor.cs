using Tenant.Infra.Enums;
using Tenant.Infra.Models.Payment;
using Tenant.Infra.Models.Tenant;
using WMInfra.Response;

namespace Tenant.Domain.Interfaces
{
    public interface ITenantProcessor
    {
        Response<int?> InsertTenantRoomDetails(TenantRoomDetails tenantRoomDetails);

        Response<TenantDashboard?> GetTenantDashboard();
        Response<List<TransactionHistory>?> GetTenantTransactions();
        Response<TenantDashboard?> GetTenantTransactionByMonthYear(string monthYear);
        Response<string> UpdatePaymentTransactionStatus(TenantPaymentResponse data);

        Response<bool?> UpdateExitDetailsForTenantRoomDetails();
    }
}
