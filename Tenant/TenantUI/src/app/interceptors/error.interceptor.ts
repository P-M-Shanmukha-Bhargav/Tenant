import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HttpErrorResponse,
  HTTP_INTERCEPTORS
} from '@angular/common/http';
import { catchError, EMPTY, Observable, tap, throwError } from 'rxjs';
import { UserService } from '../services/user.service';
import { Router } from '@angular/router';
import { Injectable } from '@angular/core';
import { ErrorResponse } from '../models/response/error-response';
import { AuthService } from '../services/auth.service';

@Injectable()
export class ErrorInterceptor implements HttpInterceptor {

  isRefreshingToken: boolean = false;
  constructor(private authService: AuthService, private router: Router) { }

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    return next.handle(request)
      .pipe(
        tap(response => console.log(JSON.stringify(response))),
        catchError((error: HttpErrorResponse) => {

          console.log(JSON.stringify(error));
          let session = this.authService.getSession();
          if (error.status === 401 && session != null && session.uid != null && !this.authService.isLoggedIn && !this.isRefreshingToken) {
            this.isRefreshingToken = true;
            console.log('Access Token is expired, we need to renew it');
            this.authService.refreshToken().then((token) => this.tokenResponse(token!));
          } else if (error.status === 400 && error.error.errorCode === 'invalid_grant') {
            console.log('the refresh token has expired, the user must login again');
            this.authService.SignOut();
            this.router.navigate(['']);


          } else {
            let errorResponse: ErrorResponse = error.error;
            console.log(JSON.stringify(errorResponse));

            return throwError(() => errorResponse);
          }

          return EMPTY;
        })
      );
  }

  tokenResponse(token: string){
    console.info('Tokens renewed, we will save them into the local storage');
    this.authService.saveReSession(token);
  }
}
export const ErrorInterceptorProvider = { provide: HTTP_INTERCEPTORS, useClass: ErrorInterceptor, multi: true };