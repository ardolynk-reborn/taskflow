import { Component, EventEmitter, Input, Output } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatLabel } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { TaskItem } from '../task-item/task-item';
import { ProjectDTO } from '../../model/dashboard.model';
import { ProjectService } from '../../services/project-service';
import { MatDialog } from '@angular/material/dialog';
import { ProjectForm } from '../project-form/project-form';
import { TaskForm } from '../task-form/task-form';
import { MatButtonModule } from '@angular/material/button';

import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-project-item',
  imports: [
    MatButtonModule,
    MatCardModule,
    MatListModule,
    MatLabel,

    TaskItem
  ],
  templateUrl: './project-item.html',
  styleUrl: './project-item.scss'
})
export class ProjectItem {
  @Input() project!: ProjectDTO;
  @Output() update = new EventEmitter<ProjectDTO>();
  @Output() delete = new EventEmitter<void>();

   constructor(public keycloak: Keycloak, private projectService: ProjectService, private dialog: MatDialog) {}

    openEditProject(project: any) {
    const dialogRef = this.dialog.open(ProjectForm, {
      data: { project },
      width: '400px',
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.update.emit(result);
        //this.getProjects(this.pageIndex, 10, this.mineOnly);
      }
    });
  }

  deleteProject(project: any) {
    if (confirm("Are you sure you want to delete this project?")) {
      this.projectService.delete(project.id).subscribe(() => {
        this.delete.emit();
        //this.getProjects(this.pageIndex, 10, this.mineOnly);
      });
    }
  }

  openTaskDialog(project: any) {
    const dialogRef = this.dialog.open(TaskForm, {
      data: { project },
      width: '600px'
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.update.emit(result);
        //this.getProjects(this.pageIndex, 10, this.mineOnly);
      }
    });
  }

  onUpdate() {
    this.update.emit(this.project);
  }
}
