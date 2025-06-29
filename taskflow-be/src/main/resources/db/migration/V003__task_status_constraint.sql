ALTER TABLE tasks
ADD CONSTRAINT chk_task_status
CHECK (status IN ('TODO', 'IN_PROGRESS', 'DONE'));