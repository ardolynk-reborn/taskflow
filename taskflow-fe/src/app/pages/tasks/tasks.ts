import { Component, OnInit } from '@angular/core';
import { TaskDTO, UserDTO } from '../../model/dashboard.model';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { TaskService } from '../../services/task-service';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { FormsModule } from '@angular/forms';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { TaskItem } from '../../components/task-item/task-item';

@Component({
  selector: 'app-tasks',
  imports: [
    FormsModule,
    MatPaginatorModule,
    MatProgressSpinnerModule,
    MatSlideToggleModule,

    TaskItem
  ],
  templateUrl: './tasks.html',
  styleUrl: './tasks.scss'
})
export class Tasks implements OnInit {
  
  mineOnly = false;
  userId?: number;

  readonly statuses = ['TODO', 'IN_PROGRESS', 'DONE'];

  displayableMap: Record<string, string> = {
    TODO: "TODO",
    IN_PROGRESS: "IN PROGRESS",
    DONE: "DONE"
  };

  tasksMap: Record<string, TaskDTO[]> = {
    TODO: [],
    IN_PROGRESS: [],
    DONE: []
  };

  totalElementsMap: Record<string, number> = {
    TODO: 0,
    IN_PROGRESS: 0,
    DONE: 0
  };

  pageSizeMap: Record<string, number> = {
    TODO: 10,
    IN_PROGRESS: 10,
    DONE: 10
  };

  pageIndexMap: Record<string, number> = {
    TODO: 0,
    IN_PROGRESS: 0,
    DONE: 0
  };

  users: UserDTO[] = [];

  constructor(private taskService: TaskService) {}

  isLoading: Record<string, boolean> = {
    TODO: false,
    IN_PROGRESS: false,
    DONE: false
  };

  ngOnInit(): void {
    this.loadAllTasks();
  }

  loadAllTasks() {
    this.statuses.forEach(status => {
      this.loadTasksForStatus(status);
    });
  }

  loadTasksForStatus(status: string) {
    this.isLoading[status] = true;
    this.taskService
      .getTasks(this.pageIndexMap[status], this.pageSizeMap[status], this.mineOnly, [status])
      .subscribe({
        next: page => {
          this.tasksMap[status] = page.content;
          this.totalElementsMap[status] = page.totalElements;
          this.isLoading[status] = false;
        },
        error: () => {
          this.isLoading[status] = false;
        }
      });
  }
  toggleMineOnly() {
    this.statuses.forEach(status => {
      this.pageIndexMap[status] = 0;
    });
    this.loadAllTasks();
  }

  pageChange(status: string, event: PageEvent) {
    this.pageIndexMap[status] = event.pageIndex;
    this.pageSizeMap[status] = event.pageSize;
    this.loadTasksForStatus(status);
  }

  statusChange(status: string, oldStatus: string) {
    this.loadTasksForStatus(oldStatus)
    this.pageIndexMap[status] = 0;
    this.loadTasksForStatus(status);
  }
}
