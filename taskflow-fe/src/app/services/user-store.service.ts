import { Injectable } from "@angular/core";
import { UserService } from "./user.service";
import { BehaviorSubject } from "rxjs";
import { UserDTO } from "../model/dashboard.models";

@Injectable({
    providedIn: "root",
})
export class UserStoreService {
    private userSubject = new BehaviorSubject<UserDTO[]>([]);
    users$ = this.userSubject.asObservable();
    constructor(private userService: UserService) {
        this.loadAll();
    }

    private loadAll() {
        this.userService.getAll().subscribe(users =>{
            this.userSubject.next(users)
        })
    }

    getByKeycloakId(keycloakId: string) {
        return this.userSubject.getValue().find(user => user.keycloakId === keycloakId);
    }
}