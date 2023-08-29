import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from './helpers/auth.guard';
import { OwnerGuard } from './helpers/owner.guard';
import { RoleGuard } from './helpers/role.guard';
import { TenantGuard } from './helpers/tenant.guard';
import { DashboardComponent } from './screens/owner/dashboard/dashboard.component';
import { StartScreenComponent } from './screens/start-screen/start-screen.component';
import { HomeComponent } from './screens/tenant/home/home.component';
import { PaymentresponseComponent } from './screens/tenant/paymentresponse/paymentresponse.component';
import { TransactionHistoryComponent } from './screens/tenant/transaction-history/transaction-history.component';

const routes: Routes = [
  {path:'', component: StartScreenComponent, pathMatch:"full"},
  {path:'dashboard', component: DashboardComponent, canActivate:[AuthGuard, OwnerGuard]},
  
  {path:'home', component: HomeComponent, canActivate:[AuthGuard, TenantGuard]},
  {path:'History', component: TransactionHistoryComponent, canActivate:[AuthGuard, TenantGuard]},
  {path:'Payment-Response/:status', component: PaymentresponseComponent, canActivate:[AuthGuard, TenantGuard]}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
