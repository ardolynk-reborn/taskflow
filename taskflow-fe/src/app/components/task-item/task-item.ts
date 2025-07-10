import { Component, EventEmitter, Input, Output } from '@angular/core';
import { MatCard, MatCardModule } from '@angular/material/card';
import { TaskDTO } from '../../model/dashboard.model';
import { MatLabel } from '@angular/material/input';
import { TaskService } from '../../services/task-service';
import { MatDialog } from '@angular/material/dialog';
import { TaskForm } from '../task-form/task-form';
import { MatButtonModule } from '@angular/material/button';
import { NotesForm } from '../notes-form/notes-form';
import { MatIconModule } from '@angular/material/icon';

import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-task-item',
  imports: [
    MatButtonModule,
    MatCardModule,
    MatIconModule,
    MatLabel
  ],
  templateUrl: './task-item.html',
  styleUrl: './task-item.scss'
})
export class TaskItem {
  @Input() task!: TaskDTO;
  @Input() showStatus = true;
  @Output() save = new EventEmitter<TaskDTO>()

  constructor(public keycloak: Keycloak, private taskService: TaskService, private dialog: MatDialog) { }

  openEditTask(task: TaskDTO) {
    const dialogRef = this.dialog.open(TaskForm, {
      data: { task },
      width: '600px'
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.save.emit(result);
      }
    });
  }

  deleteTask(task: TaskDTO) {
    if (confirm("Are you sure you want to delete this task?")) {
      this.taskService.delete(task.id).subscribe(() => {
        this.save.emit(task);
      });
    }
  }

  openNotes(task: TaskDTO) {
    const dialogRef = this.dialog.open(NotesForm, {
      data: { task },
      width: '800px'
    });
  }
}
