ALTER TABLE tasks ADD COLUMN status_updated_at TIMESTAMP NOT NULL DEFAULT NOW();
CREATE INDEX idx_tasks_status_updated_at ON tasks(status_updated_at);