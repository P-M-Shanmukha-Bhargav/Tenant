using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WMInfra.Response;

namespace Tenant.Domain.Interfaces
{
    public interface ITransactionProcessor
    {
        Response<int?> AddTransactionAmounts();
        Response<int?> AddTransactionAmountById(int id);
    }
}
