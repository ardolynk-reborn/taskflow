export interface TaskDTO {
  id: number;
  projectId: number;
  name: string;
  description?: string;
  status: string;
  assigneeId?: number;
  assigneeUsername?: string;
}

export interface ProjectDTO {
  id: number;
  ownerId: number;
  ownerUsername: string;
  name: string;
  description: string;
  tasks: TaskDTO[];
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

export interface UserDTO {
  id: number;
  username: string;
  email: string;
  keycloakId: string;
}