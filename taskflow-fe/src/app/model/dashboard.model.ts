export const statuses = ['TODO', 'IN_PROGRESS', 'DONE'];

export interface TaskDTO {
  id: number;
  projectId: number;
  name: string;
  description?: string;
  status: string;
  ownerId: number;
  ownerUuid: string;
  ownerUsername: string;
  assigneeId: number;
  assigneeUuid: string;
  assigneeUsername: string;
  createdAt: string;
  updatedAt: string;
}

export interface ProjectDTO {
  id: number;
  ownerId: number;
  ownerUuid: string;
  ownerUsername: string;
  name: string;
  description?: string;
  createdAt: string;
  updatedAt: string;
  tasks: TaskDTO[];
}

export interface UserDTO {
  id: number;
  username: string;
  email: string;
  keycloakId: string;
}

export interface NoteDTO {
  id: number;
  taskId: number;
  userId: number;
  userUuid: string;
  username: string;
  note: string;
}

export interface ProjectRequest {
  name?: string;
  description?: string;
}

export interface taskRequest {
  name?: string;
  description?: string;
  status?: string;
  assigneeId?: number;
}

export interface Page<T> {
  content: T[];
  pageable: {
    pageNumber: number;
    pageSize: number;
  };
  totalPages: number;
  totalElements: number;
}
