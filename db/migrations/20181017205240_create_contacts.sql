-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE "contacts"
(
  id serial PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  url VARCHAR(256) NOT NULL
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE "contacts"
