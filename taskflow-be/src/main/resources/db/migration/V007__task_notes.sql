CREATE TABLE notes(
    id SERIAL PRIMARY KEY,
    task_id BIGINT REFERENCES tasks(id),
    user_id BIGINT REFERENCES users(id),
    note TEXT NOT NULL
)