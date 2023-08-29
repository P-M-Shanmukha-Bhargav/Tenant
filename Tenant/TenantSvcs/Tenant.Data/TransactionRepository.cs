using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tenant.Data.Interfaces;
using Tenant.Infra.Models.Tenant;
using WMInfra.Data;

namespace Tenant.Data
{
    public class TransactionRepository : ITransactionRepository
    {
        private readonly IConfiguration _configuration;
        public TransactionRepository(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public int? AddTransactionAmountByDetails()
        {
            int? tenantRoomDetailsId = null;
            using (var connection = DbFactory.CreateConnection(_configuration.GetConnectionString(_configuration.GetValue<string>("ENV"))))
            {
                using (var command = connection.CreateCommand("[ROM].[InsertTenantRoomDetails_V1]"))
                {
                    SqlParameter outputParameter;
                    command.AddOutParameter("@TenantRoomDetailsId", SqlDbType.Int, out outputParameter);
                    command.AddWithValue("@IsActive", 1);

                    if (connection.State != ConnectionState.Open)
                        connection.Open();

                    var affectedRowsCount = command.ExecuteNonQuery();
                    if (affectedRowsCount > 0)
                    {
                        tenantRoomDetailsId = Convert.ToInt32(outputParameter.Value);
                    }
                }
            }
            return tenantRoomDetailsId;
        }
    }
}
