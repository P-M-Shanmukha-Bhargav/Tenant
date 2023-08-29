﻿using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Reflection.Metadata;

namespace Tenant.API.Handler
{
    public class AddRequiredHeaderParameterHandler : IOperationFilter
    {
        public void Apply(OpenApiOperation operation, OperationFilterContext context)
        {
            if (operation.Parameters == null)
                operation.Parameters = new List<OpenApiParameter>();

            operation.Parameters.Add(new OpenApiParameter()
            {
                Name = "Uid",
                In = ParameterLocation.Header,
                Required = true,
                Description = "Passes the UserId",
                
            });
        }
    }
}
