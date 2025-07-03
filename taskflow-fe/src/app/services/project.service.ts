import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { ProjectDTO, ProjectRequest } from "../model/dashboard.models";

@Injectable({
    providedIn: 'root'
})
export class ProjectService {
    constructor(private http: HttpClient) {}

    getAll() {
        return this.http.get<ProjectDTO[]>('/api/projects');
    }

    get(id: number) {
        return this.http.get<ProjectDTO>(`/api/projects/${id}`);
    }

    create(payload: ProjectRequest) {
        return this.http.post<ProjectDTO>('/api/projects', payload);
    }

    update(id: number, payload: ProjectRequest) {
        return this.http.put<ProjectDTO>(`/api/projects/${id}`, payload);
    }

    delete(id: number) {
        return this.http.delete<void>(`/api/projects/${id}`);
    }
}