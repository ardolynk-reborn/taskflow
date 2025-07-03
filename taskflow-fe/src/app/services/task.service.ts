import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TaskDTO, taskRequest } from "../model/dashboard.models";

@Injectable({ providedIn: 'root' })
export class TaskService {
    constructor(private http: HttpClient) {}

    getAll() {
        return this.http.get<TaskDTO[]>(`/api/tasks`);
    }

    get(id: number) {
        return this.http.get<TaskDTO>(`/api/tasks/${id}`);
    }

    create(projectId: number, payload: taskRequest) {
        console.log(`Creating task for project ${projectId}: ${JSON.stringify(payload)}`);
        return this.http.post<TaskDTO>(`/api/tasks?projectId=${projectId}`, payload);
    }

    update(id: number, payload: taskRequest) {
        return this.http.put<TaskDTO>(`/api/tasks/${id}`, payload);
    }

    delete(id: number) {
        return this.http.delete<void>(`/api/tasks/${id}`);
    }
}