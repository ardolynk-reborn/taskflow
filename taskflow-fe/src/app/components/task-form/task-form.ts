import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { ProjectDTO, TaskDTO, UserDTO } from '../../model/dashboard.model';

import { TaskService } from '../../services/task-service';
import { UserStore } from '../../services/user-store';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';

import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-task-form',
  imports: [
    CommonModule,
    ReactiveFormsModule,

    MatButtonModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule
  ],
  templateUrl: './task-form.html',
  styleUrl: './task-form.scss'
})
export class TaskForm implements OnInit {

  form!: FormGroup;
  users: UserDTO[] = [];
  statuses = ['TODO', 'IN_PROGRESS', 'DONE'];
  
  constructor(
    public keycloak: Keycloak,
    private fb: FormBuilder,
    private taskService: TaskService,
    private userStore: UserStore,
    public dialogRef: MatDialogRef<TaskForm>,
    @Inject(MAT_DIALOG_DATA)
    public data: { project?: ProjectDTO; task?: TaskDTO }
  ) {}

  ngOnInit(): void {

      console.log("Task: " + JSON.stringify(this.data.task))
      const ownedByMe = (!this.data.task || this.data.task.ownerUuid == this.keycloak.subject)

      this.form = this.fb.group({
        name: [
          {
            value: this.data.task?.name || '',
            disabled: !ownedByMe
          },
          [Validators.required, Validators.minLength(3), Validators.maxLength(255)]
        ],
        description: [
          {
            value: this.data.task?.description || '',
            disabled: !ownedByMe
          },
          Validators.maxLength(255)
        ],
        status: [this.data.task?.status || 'TODO', Validators.required],
        assigneeId: [
          {
            value: this.data.task?.assigneeId || this.data.project?.ownerId || null,
            disabled: !ownedByMe
          }
        ]
      })

      console.log('Data: ' + JSON.stringify(this.data));
      console.log('Form: ' + JSON.stringify(this.form.value));

      this.userStore.users$.subscribe(users => {
        this.users = users;
      })
  }

  save() {
    if (this.form.invalid) {
      return;
    }

    const payload = this.form.value;
    if (this.data.task) {
      this.taskService.update(this.data.task.id, payload).subscribe(task => {
        this.dialogRef.close(task);
      });
    } else {
      this.taskService.create(this.data.project?.id || this.data.task!.projectId, payload).subscribe(task => {
        this.dialogRef.close(task);
      });
    }
  }
}
