export interface TenantAmountDetails {
    totalAmount: number;
    rentAmount: number;
    maintenanceAmount: number;
    powerAmount: number;
    waterAmount: number;
    otherAmount: number;
    pendingAmount: number;
    advancePendingAmount: number;
    isAmountPaid: boolean;
    paymentType: string;
    paymentStatus: string;
}