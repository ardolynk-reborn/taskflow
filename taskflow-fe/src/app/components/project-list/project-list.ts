import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { ProjectDTO, ProjectRequest } from '../../model/dashboard.models';
import { ProjectService } from '../../services/project.service';
import { ProjectItem } from '../project-item/project-item';
import { ProjectForm } from '../project-form/project-form';

@Component({
  selector: 'app-project-list',
  imports: [ProjectItem, ProjectForm],
  templateUrl: './project-list.html',
  styleUrl: './project-list.scss'
})
export class ProjectList implements OnInit {
  projects: ProjectDTO[] = [];
  showForm = false;

  constructor(private service: ProjectService) {}

  ngOnInit() {
      this.loadProjects();
  }

  loadProjects() {
      this.service.getAll().subscribe({
        next: (projects) => this.projects = projects,
        error: (err) => console.error(err)
      });
  }

  openCreateForm() {
      this.showForm = true;
  }

  closeForm() {
      this.showForm = false;
  }

  onProjectSaved(project: ProjectRequest) {
    this.service.create(project);
    this.closeForm();
    this.loadProjects();
  }
}
