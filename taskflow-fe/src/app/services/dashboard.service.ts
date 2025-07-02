import { HttpClient } from "@angular/common/http";
import { inject, Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { ProjectDTO } from "../model/dashboard.models";

@Injectable({
    providedIn: "root"
})
export class DashboardService {
    private http = inject(HttpClient);
    private apiUrl = 'http://localhost:8000/api/projects';

    getProjects(): Observable<ProjectDTO[]> {
        return this.http.get<ProjectDTO[]>(this.apiUrl);
    }

    createProject(name: string, description?: string): Observable<ProjectDTO> {
        return this.http.post<ProjectDTO>(this.apiUrl, { name, description });
    }

    updateProject(name?: string, description?: string): Observable<ProjectDTO> {
        return this.http.put<ProjectDTO>(this.apiUrl, { name, description });
    }

    deleteProject(id: number): Observable<void> {
        return this.http.delete<void>(`${this.apiUrl}/${id}`);
    }

    getTasks(projectId: number): Observable<ProjectDTO> {
        return this.http.get<ProjectDTO>(`${this.apiUrl}/${projectId}`);
    }

    addTask(projectId: number, task: any): Observable<ProjectDTO> {
        return this.http.post<ProjectDTO>(`${this.apiUrl}/${projectId}/tasks`, task);
    }

    updateTask(projectId: number, taskId: number, task: any): Observable<ProjectDTO> {
        return this.http.put<ProjectDTO>(`${this.apiUrl}/${projectId}/tasks/${taskId}`, task);
    }
}