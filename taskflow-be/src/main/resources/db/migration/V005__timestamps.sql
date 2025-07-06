ALTER TABLE users ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT NOW();
ALTER TABLE users ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT NOW();
ALTER TABLE projects ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT NOW();
ALTER TABLE projects ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT NOW();
ALTER TABLE tasks ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT NOW();
ALTER TABLE tasks ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT NOW();

CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_users_updated_at ON users(updated_at);
CREATE INDEX idx_projects_created_at ON projects(created_at);
CREATE INDEX idx_projects_updated_at ON projects(updated_at);
CREATE INDEX idx_tasks_created_at ON tasks(created_at);
CREATE INDEX idx_tasks_updated_at ON tasks(updated_at);