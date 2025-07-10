import { Injectable } from '@angular/core';
import { UserDTO } from '../model/dashboard.model';
import { BehaviorSubject } from 'rxjs';
import { UserService } from './user-service';

@Injectable({
  providedIn: 'root'
})
export class UserStore {
  private userSubject = new BehaviorSubject<UserDTO[]>([]);
  users$ = this.userSubject.asObservable();
  constructor(private userService: UserService) { 
    this.loadAll();
  }
  loadAll() {
    this.userService.getAll().subscribe((users) => {
      this.userSubject.next(users);
    });
  }

  getByKeycloakId(keycloakId: string) {
    return this.userSubject.getValue().find(user => user.keycloakId === keycloakId);
  }
}
