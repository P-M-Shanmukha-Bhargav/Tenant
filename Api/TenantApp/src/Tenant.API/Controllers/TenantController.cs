using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Enums;
using Tenant.Infra.Models.Payment;
using Tenant.Infra.Models.Tenant;
using WMInfra.Response;

namespace Tenant.API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TenantController : ControllerBase
    {
        public readonly ITenantProcessor _tenantProcessor;
        public TenantController(ITenantProcessor tenantProcessor)
        {
            _tenantProcessor = tenantProcessor;
        }

        /// <summary>
        /// Sends tenantUId and returns the current month transaction details
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [EnableCors]
        [HttpGet("GetTenantDashboard")]
        public ObjectResult GetTenantDashboard()
        {
            var response = _tenantProcessor.GetTenantDashboard();

            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// sends teantuid and retuns transactions of current room as year and month
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [EnableCors]
        [HttpGet("GetTenantTransactions")]
        public ObjectResult GetTenantTransactions()
        {
            var response = _tenantProcessor.GetTenantTransactions();

            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// Sends tenantUId and Month-Year and returns the specified details transaction details
        /// </summary>
        /// <param name="monthYear"></param>
        /// <returns></returns>
        [EnableCors]
        [HttpGet("GetTenantTransactionByMonthYear/{month}/{year}")]
        public ObjectResult GetTenantTransactionByMonthYear(string month, int year)
        {
            var response = _tenantProcessor.GetTenantTransactionByMonthYear($"{month}-{year}");

            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// Sends tenantRoomDetails and saves the tenant details to room
        /// </summary>
        /// <param name="tenantRoomDetails"></param>
        /// <returns></returns>
        [EnableCors]
        [HttpPost("AddTenantToRoom")]
        public IActionResult AddTenantToRoom(TenantRoomDetails tenantRoomDetails)
        {
            var response = _tenantProcessor.InsertTenantRoomDetails(tenantRoomDetails);
            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// Requests and updates the tenant details to room for exit
        /// </summary>
        /// <param name="tenantRoomExitDetails"></param>
        /// <returns></returns>
        [EnableCors]
        [HttpGet("UpdateExitDetailsForTenantRoom")]
        public IActionResult UpdateExitDetailsForTenantRoomDetails()
        {
            var response = _tenantProcessor.UpdateExitDetailsForTenantRoomDetails();
            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// Add tenant Transaction details to Initiate Transaction
        /// </summary>
        /// <param name="tenantRoomExitDetails"></param>
        /// <returns></returns>
        //[UnAuthorize]
        [EnableCors]
        [HttpPost("InsertPaymentTransaction")]
        public IActionResult InsertPaymentTransaction()
        {
            var response = _tenantProcessor.UpdatePaymentTransactionStatus();
            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// Updates the tenant Transaction details from Payment
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        //[UnAuthorize]
        [EnableCors]
        [HttpPost("UpdatePaymentTransactionStatus")]
        public IActionResult UpdatePaymentTransactionStatus([FromForm]TenantPaymentResponse data)
        {
            var response = _tenantProcessor.UpdatePaymentTransactionStatus(data);
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
