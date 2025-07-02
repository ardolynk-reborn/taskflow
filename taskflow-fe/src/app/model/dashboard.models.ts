export interface TaskDTO {
  id: number;
  projectId: number;
  title: string;
  description?: string;
  status: string;
  assigneeId?: number;
}

export interface ProjectDTO {
  id: number;
  ownerId: number;
  name: string;
  description: string;
  tasks: TaskDTO[];
}

export interface ProjectRequest {
  name?: string;
  description?: string;
}

export interface taskRequest {
  title?: string;
  description?: string;
  status?: string;
  assigneeId?: number;
}