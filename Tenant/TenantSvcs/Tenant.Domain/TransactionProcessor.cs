using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tenant.Data;
using Tenant.Data.Interfaces;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Models.Tenant;
using WMInfra.Response;

namespace Tenant.Domain
{
    public class TransactionProcessor : ITransactionProcessor
    {
        private readonly ITransactionRepository _transactionRepository;
        public TransactionProcessor(ITransactionRepository transactionRepository)
        {
            _transactionRepository = transactionRepository;
        }

        public Response<int?> AddTransactionAmountById(int id)
        {
            var resp = _transactionRepository.AddTransactionAmountByDetails();
            return resp != null ? new Response<int?>(resp) :
                new Response<int?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }

        public Response<int?> AddTransactionAmounts()
        {
            var resp = _transactionRepository.AddTransactionAmountByDetails();
            return resp != null ? new Response<int?>(resp) :
                new Response<int?>(null, ResponseCode.BadRequest, new[] { new ResponseMessage() { } });
        }
    }
}
