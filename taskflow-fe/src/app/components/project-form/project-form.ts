import { CommonModule } from '@angular/common';
import { Component, Inject, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialog, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { ProjectService } from '../../services/project-service';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-project-form',
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatButtonModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule
  ],
  templateUrl: './project-form.html',
  styleUrl: './project-form.scss'
})
export class ProjectForm implements OnInit {

  form!: FormGroup;

  constructor(
    private fb: FormBuilder,
    public dialogRef: MatDialogRef<any>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private projectService: ProjectService
  ) {}

  ngOnInit() {
    this.form = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(3), Validators.maxLength(255)]],
      description: ['', Validators.maxLength(255)]
    });
    if (this.data?.project) {
      this.form.patchValue(this.data.project);
    }
  }

  save() {
    if (this.data?.project) {
      this.projectService.update(this.data.project.id, this.form.value).subscribe(project => {
        this.dialogRef.close(project);
      })
    } else {
      this.projectService.create(this.form.value).subscribe(project => {
        this.dialogRef.close(project);
      });
    }
  }
}
