import { Component } from '@angular/core';
import { MatTabsModule } from '@angular/material/tabs';
import { Router, RouterModule, RouterOutlet } from '@angular/router';
import Keycloak from 'keycloak-js';
import { Projects } from './pages/projects/projects';
import { Tasks } from './pages/tasks/tasks';
import { MatToolbar, MatToolbarModule } from '@angular/material/toolbar';
import { CommonModule } from '@angular/common';
import { MatIcon } from '@angular/material/icon';

@Component({
  selector: 'app-root',
  imports: [

    CommonModule,

    RouterOutlet,
    RouterModule,

    MatIcon,

    MatTabsModule,
    MatToolbarModule,

    Projects,
    Tasks
  ],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {

  username?: string;

  token?: string;
  constructor(public keycloak: Keycloak, private router: Router) {
    this.token = this.keycloak.token;
    this.username = keycloak.tokenParsed?.['name'];
  };

  

  isActive(path: string): boolean {
    return this.router.isActive(path, { paths: 'exact', matrixParams: 'ignored', queryParams: 'ignored', fragment: 'ignored' });
  }

  logout() {
    this.keycloak.logout({
      redirectUri: window.location.origin,
    })
  }
}
