import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ProjectDTO, TaskDTO, taskRequest, UserDTO } from '../../model/dashboard.models';
import { TaskService } from '../../services/task.service';
import { UserStoreService } from '../../services/user-store.service';

@Component({
  selector: 'app-task-form',
  imports: [CommonModule, FormsModule],
  templateUrl: './task-form.html',
  styleUrl: './task-form.scss'
})
export class TaskForm {
  @Input() project!: ProjectDTO;
  @Input() task?: TaskDTO;
  @Output() save = new EventEmitter<TaskDTO>();
  @Output() close = new EventEmitter<void>();

  model: taskRequest= { status: 'TODO' };

  statuses = ['TODO', 'IN_PROGRESS', 'DONE'];
  users: UserDTO[] = [];
  assigneeSearch = '';

  constructor(private service: TaskService, private userStore: UserStoreService) {}

  ngOnInit() {
    this.userStore.users$.subscribe(users => this.users = users);

    if (this.task) {
      this.model = {
        name: this.task.name,
        description: this.task.description,
        status: this.task.status,
        assigneeId: this.task.assigneeId
      };
    }

    this.assigneeSearch = this.task?.assigneeUsername ?? this.project?.ownerUsername ?? '';
    this.model.assigneeId = this.task?.assigneeId ?? this.project?.ownerId;
  }

  selectAssignee(user: UserDTO) {
    this.model.assigneeId = user.id;
    this.assigneeSearch = user.username;
  }

  filteredUsers() {
    const searchString = this.assigneeSearch.toLowerCase();
    return this.users.filter(user =>
      user.username.toLowerCase().includes(searchString) ||
      user.email.toLowerCase().includes(searchString)
    );
  }

  submit() {
    if (this.task) {
      this.service.update(this.task.id, this.model).subscribe((task) => this.save.emit(task));
    } else {
      this.service.create(this.project.id, this.model).subscribe((task) => this.save.emit(task));
    }
  }
}
