using Google.Cloud.Firestore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tenant.Infra.Models.Common
{
    [FirestoreData]
    public class Complaint
    {
        [FirestoreDocumentId]
        public string ComplaintId { get; set; }

        [FirestoreProperty]
        public string ComplaintTitle { get; set; }

        [FirestoreProperty]
        public string ComplaintDesc { get; set; }

        [FirestoreDocumentCreateTimestamp]
        public DateTime ComplaintCreateDate { get; set; }

        [FirestoreProperty]
        public string[] Images { get; set; }

        [FirestoreProperty]
        public bool IsResolved { get; set; }

        [FirestoreProperty]
        public string TenantId { get; set; }
    }
}
