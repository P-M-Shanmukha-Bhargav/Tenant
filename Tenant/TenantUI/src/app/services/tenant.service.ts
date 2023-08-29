import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ResponseModel } from '../models/response/response-model';
import { environment } from 'src/environments/environment';
import { TenantAmountDetails } from '../models/tenant/teant-dashboard';
import { Observable } from 'rxjs';
import { TransactionHistory } from '../models/tenant/transaction-history';

@Injectable({
  providedIn: 'root'
})
export class TenantService {

  constructor(private httpClient: HttpClient) { }

  getTenantDashboard(): Observable<ResponseModel<TenantAmountDetails>>{
    return this.httpClient.get<ResponseModel<TenantAmountDetails>>(`${environment.apiURL}/Tenant/GetTenantDashboard`);
  }
  
  getTenantTransactionHistory(): Observable<ResponseModel<TransactionHistory[]>>{
    return this.httpClient.get<ResponseModel<TransactionHistory[]>>(`${environment.apiURL}/Tenant/GetTenantTransactions`);
  }
  
  getTenantTransactionByMonthYear(month:string, year:number): Observable<ResponseModel<TenantAmountDetails>>{
    return this.httpClient.get<ResponseModel<TenantAmountDetails>>(`${environment.apiURL}/Tenant/GetTenantTransactionByMonthYear/`+month+'/'+year);
  }
  
  updateTransactionBillPaymentStatus(): Observable<ResponseModel<Boolean>>{
    return this.httpClient.get<ResponseModel<Boolean>>(`${environment.apiURL}/Tenant/UpdateTransactionBillPaymentStatus`);
  }
}
