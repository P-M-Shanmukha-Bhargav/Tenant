using FirebaseAdmin.Auth.Multitenancy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tenant.Infra.Models.Common;

namespace Tenant.Domain.Interfaces
{
    public interface IComplaintProcessor
    {
        Task<string> AddComplaint(string roomId, Complaint complaint);
        Task<List<Complaint>> GetMyComplaintList(string roomId, string tenantId);
        Task<Complaint> GetComplaintByRoomIdAndComplaintId(string roomId, string complaintId);
    }
}
