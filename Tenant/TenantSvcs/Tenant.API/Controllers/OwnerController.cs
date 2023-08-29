using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Models.Owner;
using WMInfra.Response;

namespace Tenant.API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class OwnerController : ControllerBase
    {
        public readonly IOwnerProcessor _ownerProcessor;
        public OwnerController(IOwnerProcessor ownerProcessor)
        {
            _ownerProcessor = ownerProcessor;
        }

        /// <summary>
        /// Sends room data and inserts w.r.t owner
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [HttpPost("InsertRoomDetails")]
        public ObjectResult InsertRoomDetails(Room room)
        {
            var response = _ownerProcessor.InsertRoomDetails(room);

            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// Added or Updates for power, water and other amounts
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [HttpPost("InsertTransactionDetails")]
        public ObjectResult InsertTransactionDetails(TransactionDetails transactionDetails)
        {
            var response = _ownerProcessor.InsertTransactionDetails(transactionDetails);

            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// Get Tenant room data to listout in dashboard
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [HttpGet("GetOwnerDashboard")]
        public ObjectResult GetOwnerDashboard()
        {
            var response = _ownerProcessor.GetAllRoomsOfTenant();

            if (response == null)
                return BadRequest(new Exception("Request object is null."));

            if (response.Code == ResponseCode.OK)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        /// <summary>
        /// Get room data by roomId when clicked on room
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        [HttpGet("GetOwnerDashboard/{roomId}")]
        public ObjectResult GetOwnerDashboard(Guid roomId)
        {
            var response = _ownerProcessor.GetRoomDetailsByRoomId(roomId);

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
