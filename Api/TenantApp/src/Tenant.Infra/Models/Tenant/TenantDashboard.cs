
namespace Tenant.Infra.Models.Tenant
{
    public class TenantDashboard
    {
        public decimal TotalAmount { get; set; }
        public decimal RentAmount { get; set; }
        public decimal MaintenanceAmount { get; set; }
        public decimal PowerAmount { get; set; }
        public decimal WaterAmount { get; set; }
        public decimal OtherAmount { get; set; }
        public decimal PendingAmount { get; set; }
        public decimal AdvancePendingAmount { get; set; }
        public bool IsAmountPaid { get; set; }
        public bool IsBillsOwnerControl { get; set; }
        public string PaymentType { get; set; }
        public string PaymentStatus { get; set; }
    }
}
