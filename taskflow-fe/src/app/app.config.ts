import { ApplicationConfig, provideBrowserGlobalErrorListeners, provideZoneChangeDetection } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { provideKeycloak } from 'keycloak-angular';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { apiInterceptor } from './interceptors/api.interceptor';
import { authInterceptor } from './interceptors/auth.interceptor';

export const appConfig: ApplicationConfig = {
  providers: [
    provideKeycloak({
      config: {
        url: 'http://localhost:7080',
        realm: 'taskflow',
        clientId: 'angular'
      },
      initOptions: {
        onLoad: 'login-required',
        silentCheckSsoRedirectUri: `${window.location.origin}/assets/silent-check-sso.html`
      }
    }),
    provideHttpClient(withInterceptors([apiInterceptor, authInterceptor])),
    provideBrowserGlobalErrorListeners(),
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes)
  ]
};
