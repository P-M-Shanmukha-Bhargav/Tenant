import { Component } from '@angular/core';
import { TenantService } from 'src/app/services/tenant.service';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { TenantAmountDetails } from 'src/app/models/tenant/teant-dashboard';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Router } from '@angular/router';
import { PaymentService } from 'src/app/services/payment.service';
import { environment } from '../../../../environments/environment';
import { NzModalRef, NzModalService } from 'ng-zorro-antd/modal';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  tenantData!: TenantAmountDetails;
  payuform: any;
  
  constructor(private tenantService: TenantService, private notification: NzNotificationService,
    private router: Router, private paymentService: PaymentService, private modal: NzModalService) {
    this.tenantService.getTenantDashboard()
      .subscribe((result) => {
        if(result.model != null){
          this.tenantData = result.model;
        }
        else{
          result.messages.forEach(message => {
            this.notification.error("Error", message.message);
          });
        }
      }, (error) => { console.log(error); this.notification.error("Error", error); });
  }

  makePayment(totalAmount: any){

    const modal: NzModalRef = this.modal.create({
      nzTitle: 'Payment Options',
      nzFooter: [
        {
          label: 'Close',
          type: 'primary',
          danger: true,
          onClick: () => modal.destroy()
        },
        {
          label: 'Cash Payment',
          type: 'primary',
          onClick: () => {

            modal.destroy();
          }
        },
        {
          label: 'Online Payment',
          type: 'primary',
          onClick: () => {
            var trxId = this.paymentService.generateTrxId();
            var productinfo = this.paymentService.generateProductInfo();
            var displayName = JSON.parse(window.localStorage.getItem("user")!).displayName;
            var emailId = JSON.parse(window.localStorage.getItem("user")!).email;
            var phone = JSON.parse(window.localStorage.getItem("user")!).phoneNumber;
            var key = environment.payment.key;
            var salt = environment.payment.salt;

            this.paymentService.generateHash(`${key}|${trxId}|${totalAmount}|${productinfo}|${displayName}|${emailId}|||||||||||${salt}`)
            .then((resp) => {
              var params = {
                key: key,
                txnid: trxId,
                productinfo: productinfo,
                amount: totalAmount.toString(),
                email: emailId,
                firstname: displayName,
                surl: environment.apiURL + environment.payment.surl,
                furl: environment.apiURL + environment.payment.furl,
                phone: phone,
                hash: resp,
                salt: salt
              };

              this.paymentService.makePayment(params)
            });
            modal.destroy();
          }
        },
      ]
    });
  }

  navigateToHistoryList(){
    this.router.navigate(["History"]);
  }
}
