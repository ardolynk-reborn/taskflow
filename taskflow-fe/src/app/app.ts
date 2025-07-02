import { Component, inject } from '@angular/core';
import { RouterOutlet } from '@angular/router';
// import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {
  protected title = 'taskflow-fe';
  // protected keycloak = inject(Keycloak);
  // protected token = this.keycloak.token;
  // protected name = (this.keycloak.tokenParsed as any)?.name;
}
