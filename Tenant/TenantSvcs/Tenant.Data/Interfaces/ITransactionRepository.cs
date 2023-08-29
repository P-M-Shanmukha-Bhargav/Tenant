using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Data.Interfaces
{
    public interface ITransactionRepository
    {
        int? AddTransactionAmountByDetails();
    }
}
