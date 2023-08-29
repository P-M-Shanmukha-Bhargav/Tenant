using FirebaseAdmin.Auth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using Tenant.Data.Interfaces;
using Tenant.Infra.Instances;
using Tenant.Infra.Models.Common;

namespace Tenant.Data
{
    public class ComplaintRepository : IComplaintRepository
    {
        public async Task<string> AddComplaint(string roomId, Complaint complaint)
        {
            var doc = await FirebaseDb.GetFirebaseDbApp
                .Collection("rooms")
                .Document(roomId)
                .Collection("complaint")
                .AddAsync(complaint);

            return doc.Id.ToString();
        }

        public async Task<Complaint> GetComplaintByRoomIdAndComplaintId(string roomId, string complaintId)
        {
            var res = await FirebaseDb.GetFirebaseDbApp
                .Collection("rooms")
                .Document(roomId)
                .Collection("complaint")
                .Document(complaintId)
                .GetSnapshotAsync();

            return res.ConvertTo<Complaint>();
        }

        public async Task<List<Complaint>> GetMyComplaintList(string roomId, string tenantId)
        {
            var result = new List<Complaint>();
            var res = await FirebaseDb.GetFirebaseDbApp
                .Collection("rooms")
                .Document(roomId)
                .Collection("complaint")
                .WhereEqualTo("TenantId", tenantId).GetSnapshotAsync();

            var documentList = res.Select(x => x.ConvertTo<Complaint>()).ToList();

            return documentList;
        }
    }
}
