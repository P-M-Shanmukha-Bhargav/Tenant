import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { Login } from 'src/app/models/request/login';
import { Register } from 'src/app/models/request/register';
import { ResponseModel } from 'src/app/models/response/response-model';
import { TokenResponse } from 'src/app/models/response/token-response';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private httpClient: HttpClient) { }

  login(loginRequest: Login): Observable<ResponseModel<TokenResponse>> {
    return this.httpClient.post<ResponseModel<TokenResponse>>(`${environment.apiURL}/User/LoginUser`, loginRequest);
  }

  signup(SignupRequest: Register): Observable<ResponseModel<number>> {
    return this.httpClient.post<ResponseModel<number>>(`${environment.apiURL}/User/RegisterUser`, SignupRequest);
  }

  refreshToken() {
    return this.httpClient.get<ResponseModel<string>>(`${environment.apiURL}/User/RefreshToken`);
  }

  logout() {
    return this.httpClient.post(`${environment.apiURL}/User/Logout`, null);
  }

  // handleError(err: HttpErrorResponse) {

  //     let errorMessage = '';
  //     if (err.error instanceof ErrorEvent) {

  //         errorMessage = `An error occurred: ${err.error.message}`;
  //     } else {

  //         errorMessage = `Server returned code: ${err.status}, error message is: ${err.message}`;
  //     }
  //     console.error(errorMessage);
  //     return throwError(errorMessage);
  // }

}
