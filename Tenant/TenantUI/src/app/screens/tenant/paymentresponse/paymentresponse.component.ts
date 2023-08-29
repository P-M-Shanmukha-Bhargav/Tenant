import { Component } from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import { PaymentService } from 'src/app/services/payment.service';

@Component({
  selector: 'app-paymentresponse',
  templateUrl: './paymentresponse.component.html',
  styleUrls: ['./paymentresponse.component.css']
})
export class PaymentresponseComponent {

  constructor(private _route : ActivatedRoute, private paymentService: PaymentService){
    this._route.paramMap.subscribe((params)=>{
      //change the value of showRoutes based on your requirements
      console.log(params.get('status'));
     }); 
  }
}
