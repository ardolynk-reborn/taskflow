import { ApplicationConfig, provideBrowserGlobalErrorListeners, provideZoneChangeDetection } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { provideKeycloak } from 'keycloak-angular';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { authInterceptor } from './interceptors/auth.interceptor';
import { environment } from '../environments/environment';
import { apiInterceptor } from './interceptors/api.interceptor';

export const appConfig: ApplicationConfig = {
  providers: [
    // TODO: get rid of hardcoded values
    provideKeycloak({
      config: {
        url: environment.keycloakUrl,
        realm: 'taskflow',
        clientId: 'angular',
      },
      initOptions: {
        onLoad: 'login-required',//'check-sso',
        silentCheckSsoRedirectUri: `${window.location.origin}/assets/silent-check-sso.html`
      }
    }),
    provideHttpClient(withInterceptors([apiInterceptor, authInterceptor])),
    provideBrowserGlobalErrorListeners(),
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes)
  ]
};
