-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE "users"
(
  id serial PRIMARY KEY,
  nickname VARCHAR(60) NOT NULL,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  token VARCHAR(256)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE "users";
