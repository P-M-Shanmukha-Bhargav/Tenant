using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tenant.Infra.Models.Common;
using Tenant.Infra.Models.Tenant;

namespace Tenant.Data.Interfaces
{
    public interface ITenantRepository
    {
        int? InsertTenantRoomDetails(TenantRoomDetails tenantRoomDetails);

        List<string> GetTenantTransactionsByTenantUId();
        TenantDashboard? GetTenantTransactionByMonthYear(string monthYear);

        bool? UpdateExitDetailsForTenantRoomDetails();
    }
}
