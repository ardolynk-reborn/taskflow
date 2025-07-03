import { Component, EventEmitter, Input, Output } from '@angular/core';
import { ProjectDTO } from '../../model/dashboard.models';
import { ProjectService } from '../../services/project.service';
import { ProjectForm } from '../project-form/project-form';
import { TaskList } from "../task-list/task-list";

@Component({
  selector: 'app-project-item',
  imports: [ProjectForm, TaskList],
  templateUrl: './project-item.html',
  styleUrl: './project-item.scss'
})
export class ProjectItem {
  @Input() project!: ProjectDTO;
  @Output() refresh = new EventEmitter<void>();

  editing = false;

  constructor(private service: ProjectService) {}

  edit() {
    this.editing = true;
  }

  delete() {
    if (confirm('Are you sure you want to delete this project?')) {
      this.service.delete(this.project.id).subscribe(() => this.refresh.emit());
    }
  }

  onUpdate() {
    console.log("Updating projects")
    this.editing = false;
    this.refresh.emit();
  }
}
