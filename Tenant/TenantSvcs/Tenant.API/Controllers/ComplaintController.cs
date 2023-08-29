using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Tenant.Domain.Interfaces;
using Tenant.Domain;
using Tenant.Infra.Models.Common;
using Microsoft.AspNetCore.Authorization;

namespace Tenant.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ComplaintController : ControllerBase
    {
        public readonly IComplaintProcessor _complaintProcessor;
        public ComplaintController(IComplaintProcessor complaintProcessor)
        {
            _complaintProcessor = complaintProcessor;
        }

        /// <summary>
        /// Address added at register or at the Settings
        /// </summary>
        /// <param name="userAddress"></param>
        /// <returns></returns>
        [HttpPost("AddComplaint")]
        public async Task<ObjectResult> AddComplaint(string roomId, Complaint complaint)
        {
            var response = await _complaintProcessor.AddComplaint(roomId, complaint);
            return Ok(response);
        }

        /// <summary>
        /// Address added at register or at the Settings
        /// </summary>
        /// <param name="userAddress"></param>
        /// <returns></returns>
        [HttpGet("GetComplaintList")]
        public async Task<ObjectResult> GetComplaintList([FromQuery]string roomId, [FromQuery]string tenantId)
        {
            var response = await _complaintProcessor.GetMyComplaintList(roomId, tenantId);
            return Ok(response);
        }

        /// <summary>
        /// Address added at register or at the Settings
        /// </summary>
        /// <param name="userAddress"></param>
        /// <returns></returns>
        [HttpGet("GetComplaintListById")]
        public async Task<ObjectResult> GetComplaintListById([FromQuery] string roomId, [FromQuery] string complaintId)
        {
            var response = await _complaintProcessor.GetComplaintByRoomIdAndComplaintId(roomId, complaintId);
            return Ok(response);
        }
    }
}
