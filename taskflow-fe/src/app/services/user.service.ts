import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { UserDTO } from "../model/dashboard.models";

@Injectable({
    providedIn: "root",
})
export class UserService {
    constructor(private http: HttpClient) {}

    getAll() {
        return this.http.get<UserDTO[]>("/api/users");
    }
}