using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Tenant.Domain.Interfaces;
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
        [HttpGet("GetTenantTransactionByMonthYear/{monthYear}")]
        public ObjectResult GetTenantTransactionByMonthYear(string monthYear)
        {
            var response = _tenantProcessor.GetTenantTransactionByMonthYear(monthYear);

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
        [HttpPut("UpdateExitDetailsForTenantRoom")]
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
    }
}
