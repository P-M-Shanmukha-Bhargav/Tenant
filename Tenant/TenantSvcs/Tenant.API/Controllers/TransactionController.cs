using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Models.Tenant;
using WMInfra.Response;

namespace Tenant.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TransactionController : ControllerBase
    {
        public readonly ITransactionProcessor _transactionProcessor;
        public TransactionController(ITransactionProcessor transactionProcessor)
        {
            _transactionProcessor = transactionProcessor;
        }

        /// <summary>
        /// Sends tenantRoomDetails and saves the tenant details to room
        /// </summary>
        /// <param name="tenantRoomDetails"></param>
        /// <returns></returns>
        [HttpPost("AddTransactionAmountById/{id}")]
        public IActionResult AddTransactionAmountById(int id)
        {
            var response = _transactionProcessor.AddTransactionAmountById(id);
            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }
    }
}
