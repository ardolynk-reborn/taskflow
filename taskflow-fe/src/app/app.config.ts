import { ApplicationConfig, provideBrowserGlobalErrorListeners, provideZoneChangeDetection } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { provideKeycloak } from 'keycloak-angular';

export const appConfig: ApplicationConfig = {
  providers: [
    // TODO: get rid of hardcoded values
    provideKeycloak({
      config: {
        url: 'http://localhost:7080',
        realm: 'taskflow',
        clientId: 'angular',
      },
      initOptions: {
        onLoad: 'login-required',//'check-sso',
        silentCheckSsoRedirectUri: `${window.location.origin}/assets/silent-check-sso.html`
      }
    }),
    provideBrowserGlobalErrorListeners(),
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes)
  ]
};
