import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class RoleGuard implements CanActivate {
  constructor(public auth: AuthService, public router: Router) {}
  
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
    // this will be passed from the route config
    // on the data property
    const expectedRole = route.data['expectedRole'];
    const token = localStorage.getItem('token');
    // decode the token to get its payload
    if(localStorage.getItem("userData") == null || localStorage.getItem("userData") == undefined)
      return false;
    else{
      const tokenPayload = JSON.parse(localStorage.getItem("userData")?.toString()!);
      if (
        !this.auth.isLoggedIn || 
        tokenPayload.role !== expectedRole
      ) {
        this.router.navigate(['']);
        return false;
      }
      return true;
    }
  }
  
}
