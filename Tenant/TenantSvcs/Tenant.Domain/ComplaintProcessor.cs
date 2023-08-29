using FirebaseAdmin.Auth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tenant.Data.Interfaces;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Instances;
using Tenant.Infra.Models.Common;

namespace Tenant.Domain
{
    public class ComplaintProcessor : IComplaintProcessor
    {
        private readonly IComplaintRepository _complaintRepository;
        public ComplaintProcessor(IComplaintRepository complaintRepository)
        {
            _complaintRepository = complaintRepository;
        }
        public async Task<string> AddComplaint(string roomId, Complaint complaint)
        {
            return await _complaintRepository.AddComplaint(roomId, complaint);
        }

        public async Task<Complaint> GetComplaintByRoomIdAndComplaintId(string roomId, string complaintId)
        {
            var token = await FirebaseAuth.GetAuth(FirebaseApp.GetFirebaseApp).CreateCustomTokenAsync("");

            return await _complaintRepository.GetComplaintByRoomIdAndComplaintId(roomId, complaintId);
        }

        public async Task<List<Complaint>> GetMyComplaintList(string roomId, string tenantId)
        {
            return await _complaintRepository.GetMyComplaintList(roomId, tenantId);
        }
    }
}
