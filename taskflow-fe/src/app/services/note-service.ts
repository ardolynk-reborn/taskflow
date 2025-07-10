import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { NoteDTO, Page } from '../model/dashboard.model';

@Injectable({
  providedIn: 'root'
})
export class NoteService {

  constructor( private http: HttpClient ) { }

  getNotes(
    taskId: number,
    page: number,
    size: number,
    sort?: string,
  ) : Observable<Page<NoteDTO>> {
    let params = new HttpParams()
      .set('taskId', taskId)
      .set('page', page)
      .set('size', size);
    if (sort) {
      params = params.set('sort', sort);
    }

    return this.http.get<Page<NoteDTO>>('/api/notes', { params });
  }

  create(taskId: number, text: string) {
    return this.http.post<NoteDTO>(`/api/notes?taskId=${taskId}`, text);
  }

  update(id: number, text: string) {
    return this.http.put<NoteDTO>(`/api/notes/${id}`, text);
  }

  delete(id: number) {
    return this.http.delete<void>(`/api/notes/${id}`);
  }
}
