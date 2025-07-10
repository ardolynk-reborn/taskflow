import { Component, OnInit } from '@angular/core';
import { MatTabsModule } from '@angular/material/tabs';
import { Router, RouterModule, RouterOutlet } from '@angular/router';
import { MatToolbarModule } from '@angular/material/toolbar';
import { CommonModule } from '@angular/common';
import { MatIcon } from '@angular/material/icon';

import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-root',
  imports: [

    CommonModule,

    RouterOutlet,
    RouterModule,

    MatIcon,

    MatTabsModule,
    MatToolbarModule,
  ],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App implements OnInit {

  username?: string;

  token?: string;
  constructor(public keycloak: Keycloak, private router: Router) {
    this.token = this.keycloak.token;
    this.username = keycloak.tokenParsed?.['name'];
  };

  ngOnInit(): void {
    setInterval(() => {
      this.keycloak.updateToken(60)
        .catch(() => {
          console.error("Token refresh failed");
          this.keycloak.logout();
        });
    }, 30000);
  }

  isActive(path: string): boolean {
    return this.router.isActive(path, { paths: 'exact', matrixParams: 'ignored', queryParams: 'ignored', fragment: 'ignored' });
  }

  logout() {
    this.keycloak.logout({
      redirectUri: window.location.origin,
    })
  }
}
