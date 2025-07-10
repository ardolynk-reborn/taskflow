import { CommonModule, Location } from '@angular/common';
import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, ReactiveFormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { NoteService } from '../../services/note-service';
import { NoteDTO, TaskDTO } from '../../model/dashboard.model';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';

import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-notes',
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatButtonModule,
    MatDialogModule,
    MatIconModule,
    MatInputModule,
    MatListModule,
    MatPaginatorModule,
    MatToolbarModule
  ],
  templateUrl: './notes-form.html',
  styleUrl: './notes-form.scss'
})
export class NotesForm implements OnInit {

  task!: TaskDTO;
  notes: NoteDTO[] = [];
  newNoteControl = new FormControl('');

  editNoteId = 0;
  editNoteControl = new FormControl('');

  isLoading = false;
  isUpdating = false;

  pageIndex = 0;
  pageSize = 10;
  totalElements = 0;

  constructor(
    public keycloak: Keycloak,
    public dialogRef: MatDialogRef<any>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private noteService: NoteService
  ) {
    this.task = data.task;
  }

  ngOnInit(): void {
    this.loadNotes();
  }

  loadNotes(page = this.pageIndex) {
    this.isLoading = true;
    this.noteService.getNotes(this.task.id, page, this.pageSize).subscribe({
      next: (pageData) => {
        this.notes = pageData.content;
        this.pageIndex = pageData.pageable.pageNumber;
        this.pageSize = pageData.pageable.pageSize ?? 10;
        this.totalElements = pageData.totalElements;
        this.isLoading = false;

        console.log(JSON.stringify(this.notes));
      },
      error: () => {
        this.isLoading = false;
      }
    })
  }

  submitNote() {
    this.isLoading = true;

    const text = this.newNoteControl.value?.trim();
    if (!text) return;

    this.noteService.create(this.task.id, text).subscribe({
      next: () => {
        this.newNoteControl.reset();
        this.loadNotes(0);
      },
      error: () => {
        this.isLoading = false;
      }
    })
  }

  updateNote() {
    this.isUpdating = true;
    const text = this.editNoteControl.value?.trim();
    if (!text) return;

    this.noteService.update(this.editNoteId, text).subscribe({
      next: () => {
        this.editNoteId = 0;
        this.isUpdating = false;
        this.loadNotes(0);
      },
      error: () => {
        this.editNoteId = 0;
        this.isUpdating = false;
      }
    })
  }

  cancelEdit() {
    this.editNoteId = 0;
  }

  editNote(note: NoteDTO) {
    this.editNoteId = note.id;
    this.editNoteControl.setValue(note.note);
  }

  deleteNote(id: number): void {
    console.log('delete note', id);
    if (confirm('Delete this note?')) {
      this.noteService.delete(id).subscribe(() => this.loadNotes());
    }
  }

  onPageChange(e: PageEvent) {
    this.pageIndex = e.pageIndex;
    this.pageSize = e.pageSize;
    this.loadNotes();
  }
}
