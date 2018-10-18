-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

ALTER TABLE projects
  ADD COLUMN email VARCHAR(100) NOT NULL;

ALTER TABLE users
  ADD COLUMN email VARCHAR(100) NOT NULL;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
