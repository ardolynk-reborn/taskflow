import { Component, inject, OnInit } from '@angular/core';
import { ProjectDTO } from '../model/dashboard.models';
import { DashboardService } from '../services/dashboard.service';
import { FormsModule } from '@angular/forms';
// import { RouterOutlet } from '@angular/router';
// import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-dashboard',
  imports: [FormsModule],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.scss'
})
export class Dashboard implements OnInit {
  protected projects: ProjectDTO[] = [];
  protected newProjectName: string = '';
  protected newProjectDescription: string = '';
  private dashboardService = inject(DashboardService);

  // protected token = inject(Keycloak).token;

  ngOnInit(): void {
      this.dashboardService.getProjects().subscribe({
        next: (projects) => this.projects = projects,
        error: (err) => console.error(err)
      });
  }

  createProject() {
    this.dashboardService.createProject(this.newProjectName, this.newProjectDescription).subscribe({
      next: (project) => this.projects.push(project),
      error: (err) => console.error(err)
    });
  }
}
