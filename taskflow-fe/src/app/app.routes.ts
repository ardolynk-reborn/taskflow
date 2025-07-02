import { Routes } from '@angular/router';
import { Dashboard } from './dashboard/dashboard';
import { authGuard } from '../../sandbox/auth.guard';
import { Login } from '../../sandbox/login/login';

export const routes: Routes = [
    {
        path: 'dashboard',
        component: Dashboard
    },
    {
        path: '',
        redirectTo: 'dashboard',
        pathMatch: 'full'
    }
];
