using Google.Api;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.OpenApi.Models;
using Quartz;
using Tenant.API.Triggers;
using Tenant.Data;
using Tenant.Data.Interfaces;
using Tenant.Domain;
using Tenant.Domain.Interfaces;
using Tenant.Infra.Handlers;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "TeantAPI",
        Version = "v1"
    });
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please insert JWT with Bearer into field",
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey,

    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement {
   {
     new OpenApiSecurityScheme
     {
       Reference = new OpenApiReference
       {
         Type = ReferenceType.SecurityScheme,
         Id = "Bearer"
       }
      },
      new string[] { }
    }
  });
});

builder.Services.AddCors(policyBuilder =>
    policyBuilder.AddDefaultPolicy(policy =>
        policy.WithOrigins("*").AllowAnyHeader().AllowAnyHeader())
);

//builder.Services.AddQuartz(q =>
//{
//    q.UseMicrosoftDependencyInjectionScopedJobFactory();
//    // Just use the name of your job that you created in the Jobs folder.
//    var jobKey = new JobKey("AddTransactionAmountByTenantDetails");
//    q.AddJob<AddTransactionAmountByTenantDetails>(opts => opts.WithIdentity(jobKey));

//    q.AddTrigger(opts => opts
//        .ForJob(jobKey)
//        .WithIdentity("AddTransactionAmountByTenantDetails-trigger")
//        //This Cron interval can be described as "run every minute" (when second is zero)
//        .WithCronSchedule("0 0 0 1 * *")
//    );
//});
//builder.Services.AddQuartzHostedService(q => q.WaitForJobsToComplete = true);

//auth
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddScheme<AuthenticationSchemeOptions, FirebaseAuthenticationHandler>(JwtBearerDefaults.AuthenticationScheme, (o) => { });
builder.Services.AddAuthorization();

//business
builder.Services.AddSingleton<ITenantProcessor, TenantProcessor>();
builder.Services.AddSingleton<IComplaintProcessor, ComplaintProcessor>();
builder.Services.AddSingleton<IOwnerProcessor, OwnerProcessor>();

//data
builder.Services.AddSingleton<ITenantRepository, TenantRepository>();
builder.Services.AddSingleton<IComplaintRepository, ComplaintRepository>();
builder.Services.AddSingleton<IOwnerRepository, OwnerRepository>();

//
builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
