import { Component, EventEmitter, Input, Output } from '@angular/core';
import { ProjectDTO, TaskDTO } from '../../model/dashboard.models';
import { FormsModule } from '@angular/forms';
import { TaskItem } from "../task-item/task-item";
import { TaskForm } from '../task-form/task-form';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-task-list',
  imports: [CommonModule, FormsModule, TaskItem, TaskForm],
  templateUrl: './task-list.html',
  styleUrl: './task-list.scss'
})
export class TaskList {
  @Input() project!: ProjectDTO
  @Output() refresh = new EventEmitter<void>()

  creating = false;

  openCreateForm() {
    this.creating = true;
  }

  onCreated(task: TaskDTO) {
    this.creating = false;
    this.refresh.emit();
  }

  closeForm() {
    this.creating = false;
  }

  tmpRefresh() {
    console.log("Refreshing (list)")
    this.refresh.emit();
  }
}
