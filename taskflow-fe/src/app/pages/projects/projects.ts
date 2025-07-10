import { Component, OnInit, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { ProjectService } from '../../services/project-service';
import { ProjectDTO, UserDTO } from '../../model/dashboard.model';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { UserStore } from '../../services/user-store';
import { MatDialog } from '@angular/material/dialog';
import { ProjectForm } from '../../components/project-form/project-form';
import { MatButtonModule } from '@angular/material/button';
import { ProjectItem } from '../../components/project-item/project-item';
import { MatPaginator, MatPaginatorModule, PageEvent } from '@angular/material/paginator';

@Component({
  selector: 'app-projects',
  imports: [
    FormsModule,

    MatButtonModule,
    MatSlideToggleModule,
    MatProgressSpinnerModule,
    MatPaginatorModule,

    ProjectItem
  ],
  templateUrl: './projects.html',
  styleUrl: './projects.scss'
})
export class Projects implements OnInit {
  mineOnly = false;
  projects: ProjectDTO[] = [];
  users: UserDTO[] = [];
  pageSize = 10;
  pageIndex = 0;
  totalElements = 0;
  isLoading = false;

  constructor(private projectService: ProjectService, private userStore: UserStore, private dialog: MatDialog) { }

   @ViewChild(MatPaginator) paginator?: MatPaginator;

  getProjects(page: number, size: number, mineOnly?: boolean, sort: string = "createdAt:desc") {
    this.isLoading = true;
    this.projectService.getProjects(page, size, mineOnly, sort).subscribe({
      next: (pageData) => {
      if (pageData.totalPages > 0 && page >= pageData.totalPages) {
        // Try again with the last page
        this.getProjects(pageData.totalPages - 1, size, mineOnly, sort);
        return;
      }
        this.projects = pageData.content;
        this.pageIndex = pageData.pageable.pageNumber;
        this.pageSize = pageData.pageable.pageSize ?? 10;
        this.totalElements = pageData.totalElements;
        this.isLoading = false;
      },
      error: () => {
        this.isLoading = false;
      }
    })
  }

  loadProjects(event?: PageEvent) {
    this.pageIndex = event?.pageIndex ?? this.pageIndex;
    this.pageSize = event?.pageSize ?? this.pageSize;
    this.getProjects(this.pageIndex, this.pageSize, this.mineOnly);
  }

  ngOnInit(): void {
    this.getProjects(this.pageIndex, this.pageSize, this.mineOnly);
    this.userStore.users$.subscribe(users => this.users = users);
  }

  onMineOnlyChange() {
    this.pageIndex = 0;
    this.getProjects(0, this.pageSize, this.mineOnly);
  }

  openAddProject() {
    const dialogRef = this.dialog.open(ProjectForm, {
      width: '400px',
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.getProjects(0, this.pageSize, this.mineOnly);
      }
    });
  }

  onUpdate(_: any) {
    this.getProjects(this.pageIndex, this.pageSize, this.mineOnly);
  }

  onDelete() {
    this.getProjects(this.pageIndex, this.pageSize, this.mineOnly);
  }

  saveTask(task: any) {
    this.getProjects(this.pageIndex, this.pageSize, this.mineOnly);
  }
}
