using Quartz;
using Tenant.Domain.Interfaces;

namespace Tenant.API.Triggers
{
    public class AddTransactionAmountByTenantDetails : IJob
    {
        public readonly ITransactionProcessor _transactionProcessor;
        public AddTransactionAmountByTenantDetails(ITransactionProcessor transactionProcessor)
        {
            _transactionProcessor = transactionProcessor;
        }

        public Task Execute(IJobExecutionContext context)
        {
            _transactionProcessor.AddTransactionAmounts();
            return Task.CompletedTask;
        }
    }
}
