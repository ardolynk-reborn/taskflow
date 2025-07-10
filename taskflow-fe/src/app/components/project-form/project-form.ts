import { CommonModule } from '@angular/common';
import { Component, Inject, Output } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialog, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { ProjectService } from '../../services/project-service';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-project-form',
  imports: [
    CommonModule,
    FormsModule,
    MatButtonModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule
  ],
  templateUrl: './project-form.html',
  styleUrl: './project-form.scss'
})
export class ProjectForm {
  model = {
    name: '',
    description: ''
  };

  constructor(
    public dialogRef: MatDialogRef<any>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private projectService: ProjectService
  ) {
    if (data?.project) {
      this.model = { ...data.project};
    }
  }

  save() {
    console.log("Saving model " + JSON.stringify( this.model));
    if (this.data?.project) {
      this.projectService.update(this.data.project.id, this.model).subscribe(project => {
        this.dialogRef.close(project);
      })
    } else {
      this.projectService.create(this.model).subscribe(project => {
        this.dialogRef.close(project);
      });
    }
  }
}
