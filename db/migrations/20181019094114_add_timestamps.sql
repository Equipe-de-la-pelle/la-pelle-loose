-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

ALTER TABLE "users"
  ADD COLUMN created_at TIMESTAMP,
  ADD COLUMN updated_at TIMESTAMP;

ALTER TABLE "projects"
  ADD COLUMN created_at TIMESTAMP,
  ADD COLUMN updated_at TIMESTAMP;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
