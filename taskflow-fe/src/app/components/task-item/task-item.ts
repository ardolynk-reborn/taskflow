import { CommonModule } from '@angular/common';
import { Component, EventEmitter, input, Input, Output } from '@angular/core';
import { ProjectDTO, TaskDTO } from '../../model/dashboard.models';
import { TaskService } from '../../services/task.service';
import { FormsModule } from '@angular/forms';
import { TaskForm } from '../task-form/task-form';

@Component({
  selector: 'app-task-item',
  imports: [CommonModule, FormsModule, TaskForm],
  templateUrl: './task-item.html',
  styleUrl: './task-item.scss'
})
export class TaskItem {
  @Input() project!: ProjectDTO;
  @Input() task!: TaskDTO;
  @Output() refresh = new EventEmitter<void>();

  editing = false;

  constructor(private service: TaskService) {}

  edit() {
    console.log("Editing task");
    this.editing = true;
  }

  delete() {
    this.service.delete(this.task.id).subscribe(() => { console.log("Deleted task"); this.refresh.emit()});
  }

  onUpdated() {
    console.log("Finished editing task");
    this.editing = false;
    this.refresh.emit();
  }
}
