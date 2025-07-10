import { Routes } from '@angular/router';
import { Projects } from './pages/projects/projects';
import { Tasks } from './pages/tasks/tasks';
// import { NotesForm } from './components/notes-form/notes-form';

export const routes: Routes = [
    {
        path: 'projects', component: Projects
    },
    {
        path: 'tasks', component: Tasks
    },
    {
        path: '', redirectTo: '/projects', pathMatch: 'full'
    }
];
