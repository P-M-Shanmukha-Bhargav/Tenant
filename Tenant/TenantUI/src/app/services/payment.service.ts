import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class PaymentService {

  monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  constructor() { }

  makePayment(params: any){

    let form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", environment.payment.action);
    form.setAttribute("target", "payment_popup");
    form.setAttribute("contentType", "application/x-www-form-urlencoded");

    for (const [key, value] of Object.entries(params)) {
      if (params.hasOwnProperty(key)) {
          var input = document.createElement('input');
          input.type = 'hidden';
          input.name = key;
          input.value = typeof(value) === 'string' ? value.toString() : "";
          form.appendChild(input);
      }
    }

    document.body.appendChild(form);
    window.open('about:blank','payment_popup','width=900,height=500');
    window.close();
    form.submit();
  }

  async generateHash(hashString: string): Promise<string>{
    const buf = await window.crypto.subtle.digest("SHA-512", new TextEncoder().encode(hashString));
    return Array.prototype.map.call(new Uint8Array(buf), x => (('00' + x.toString(16)).slice(-2))).join('');
  }

  generateTrxId(): string{
    return window.localStorage.getItem("ID")!
      .concat(':')
      .concat(this.getMonthName().toString())
      .concat('-')
      .concat(new Date().getFullYear().toString())
      .concat(':')
      .concat(new Date().getDate().toString())
      .concat(new Date().getHours().toString())
      .concat(new Date().getMinutes().toString())
      .concat(new Date().getSeconds().toString());
  }

  generateProductInfo(): string{
    return this.getMonthName() + "-" + new Date().getFullYear() + " Payment";
  }

  getMonthName(): string{
    return this.monthNames[new Date().getMonth()];
  }
}
