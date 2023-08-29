import { Component } from '@angular/core';
import { TenantService } from 'src/app/services/tenant.service';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { TransactionHistory } from 'src/app/models/tenant/transaction-history';
import { TenantAmountDetails } from 'src/app/models/tenant/teant-dashboard';

@Component({
  selector: 'app-transaction-history',
  templateUrl: './transaction-history.component.html',
  styleUrls: ['./transaction-history.component.css']
})
export class TransactionHistoryComponent {
  transactions: TransactionHistory[] = [];
  transactionMonthYearDetails!: TenantAmountDetails;

  constructor(private tenantService: TenantService, private notification: NzNotificationService){
    this.tenantService.getTenantTransactionHistory()
      .subscribe((result) => {
        if(result.model != null)
          this.transactions = result.model;
        else{
          result.messages.forEach(message => {
            this.notification.error("Error", message.message);
          });
        }
      }, (error) => { console.log(error); this.notification.error("Error", error); });
  }

  loadCurrentMonth(value: TransactionHistory){
    if(value.active)
    {
      this.tenantService.getTenantTransactionByMonthYear(value.month, value.year)
      .subscribe((result) => {
        if(result.model != null)
          this.transactionMonthYearDetails  = result.model;
        else{
          result.messages.forEach(message => {
            this.notification.error("Error", message.message);
          });
        }
      }, (error) => { console.log(error); this.notification.error("Error", error); });
    }
  }
}
