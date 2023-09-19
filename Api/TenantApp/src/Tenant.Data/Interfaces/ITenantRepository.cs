using Tenant.Infra.Enums;
using Tenant.Infra.Models.Payment;
using Tenant.Infra.Models.Tenant;

namespace Tenant.Data.Interfaces
{
    public interface ITenantRepository
    {
        int? InsertTenantRoomDetails(TenantRoomDetails tenantRoomDetails);

        List<TransactionHistory> GetTransactionsByTenantId();
        TenantDashboard? GetTenantTransactionByMonthYear(string monthYear, string userUId = null);

        bool? UpdateExitDetailsForTenantRoomDetails();
        bool? UpdateTransactionBillPaymentStatus(PaymentStatus paymentStatus, string month, int year, string paidAmount);
        void InsertTransactionPayment(TenantPaymentResponse resp);
    }
}
