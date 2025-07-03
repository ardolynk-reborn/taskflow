import { Component } from '@angular/core';
import { ProjectList } from '../components/project-list/project-list';

@Component({
  selector: 'app-dashboard',
  imports: [ProjectList],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.scss'
})
export class Dashboard {
}