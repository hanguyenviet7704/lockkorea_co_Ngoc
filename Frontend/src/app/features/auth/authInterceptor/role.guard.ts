import { Injectable, PLATFORM_ID, Inject } from '@angular/core';
import { CanActivate, RouterStateSnapshot, ActivatedRouteSnapshot, Router } from '@angular/router';
import { UserService } from '../../../core/services/user.service';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { isPlatformBrowser } from '@angular/common';

@Injectable({
  providedIn: 'root'
})
export class RoleGuard implements CanActivate {
  constructor(
    private router: Router,
    private userService: UserService,
    @Inject(PLATFORM_ID) private platformId: Object
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> {
    console.log('RoleGuard.canActivate() - Checking access for route:', state.url);
    
    if (!isPlatformBrowser(this.platformId)) {
      console.log('RoleGuard.canActivate() - Not browser platform, denying access');
      return of(false);
    }
    
    const token = localStorage.getItem("token");
    console.log('RoleGuard.canActivate() - Token exists:', !!token);
    
    if (!token) {
      console.log('RoleGuard.canActivate() - No token found, redirecting to login');
      this.router.navigate(['/auth-login']);
      return of(false);
    }

    return this.userService.getInforUser(token).pipe(
      map(userInfor => {
        console.log('RoleGuard.canActivate() - User info retrieved:', {
          hasUser: !!userInfor,
          hasRole: !!userInfor?.role,
          roleId: userInfor?.role?.id,
          roleName: userInfor?.role?.name
        });
        
        if (userInfor && userInfor.role) {
          const roleId = userInfor.role.id;
          // Allow ADMIN (2) or STAFF (3)
          if (roleId === 2 || roleId === 3) {
            console.log('RoleGuard.canActivate() - Access granted for roleId:', roleId);
            return true;
          } else {
            console.log('RoleGuard.canActivate() - Access denied. Expected roleId: 2 (ADMIN) or 3 (STAFF), got:', roleId);
          }
        } else {
          console.log('RoleGuard.canActivate() - Access denied. No role found');
        }
        // Not admin or staff, redirect to home
        this.router.navigate(['/Home']);
        return false;
      }),
      catchError((err) => {
        console.error('RoleGuard.canActivate() - Error getting user info:', err);
        // API error (e.g., token expired), redirect to login
        this.router.navigate(['/auth-login']);
        return of(false);
      })
    );
  }
}