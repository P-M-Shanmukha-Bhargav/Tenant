import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HTTP_INTERCEPTORS
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserService } from '../services/user.service';
import { environment } from 'src/environments/environment';
import { AuthService } from '../services/auth.service';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor(private authService: AuthService) {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    const requestForApis = request.url.startsWith(environment.apiURL);
    const isLoggedIn = this.authService.isLoggedIn;

    console.log('inside intercept');
    console.log(`request is ${JSON.stringify(request.body)}`);
    if (isLoggedIn && requestForApis) {
      let session = this.authService.getSession();
      if (session){
        request = request.clone({ 
          headers: request.headers.set('Authorization', `Bearer ${session.accessToken}`) 
        });
        request = request.clone({ 
          headers: request.headers.set('uid', `${session.uid}`) 
        });
      }
    }
    return next.handle(request);
  }
}
export const AuthInterceptorProvider = { provide: HTTP_INTERCEPTORS, useClass: AuthInterceptor, multi: true };
