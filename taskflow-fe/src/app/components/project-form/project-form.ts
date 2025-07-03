import { Component, EventEmitter, Input, Output } from '@angular/core';
import { ProjectDTO, ProjectRequest } from '../../model/dashboard.models';
import { ProjectService } from '../../services/project.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-project-form',
  imports: [FormsModule],
  templateUrl: './project-form.html',
  styleUrl: './project-form.scss'
})
export class ProjectForm {
  @Input() project?: ProjectDTO;
  @Output() save = new EventEmitter<ProjectRequest>();
  @Output() close = new EventEmitter<void>();

  model: ProjectRequest = {};

  constructor(private service: ProjectService) {}

  ngOnInit() {
    if (this.project) {
      this.model = {
        name: this.project.name,
        description: this.project.description
      };
    }
  }

  submit() {
    if (this.project) {
      this.service.update(this.project.id, this.model).subscribe((project) => this.save.emit(project));
    } else {
      this.service.create(this.model).subscribe( (project) => { console.log("Saving project"), this.save.emit(project) });
    }
  }
}
