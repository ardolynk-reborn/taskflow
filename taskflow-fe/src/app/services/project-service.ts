import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Page, ProjectDTO, ProjectRequest } from '../model/dashboard.model';

@Injectable({
  providedIn: 'root'
})
export class ProjectService {

  constructor(private http: HttpClient) { }

  getProjects(
    page: number,
    size: number,
    mineOnly?: boolean,
    sort?: string,
  ) : Observable<Page<ProjectDTO>> {
    let params = new HttpParams()
      .set('page', page)
      .set('size', size);
    if (sort) {
      params = params.set('sort', sort);
    }
    if (mineOnly) {
      params = params.set('mineOnly', true);
    }

    return this.http.get<Page<ProjectDTO>>('/api/projects', { params });
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
