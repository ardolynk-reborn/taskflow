ALTER TABLE notes ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT NOW();
ALTER TABLE notes ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT NOW();

CREATE INDEX idx_notes_created_at ON users(created_at);
CREATE INDEX idx_notes_updated_at ON users(updated_at);
