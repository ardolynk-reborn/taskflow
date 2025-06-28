// export function initializeKeycloak(keycloak: KeycloakService) {
//     return () =>
//         keycloak.init({
//             config: {
//                 url: 'http://localhost:8080/auth',
//                 realm: 'taskflow',
//                 clientId: 'taskflow-frontend',
//             },
//             initOptions: {
//                 onLoad: 'check-sso',
//                 silentCheckSsoRedirectUri:
//                     window.location.origin + '/assets/silent-check-sso.html',
//             },
//         });
// }