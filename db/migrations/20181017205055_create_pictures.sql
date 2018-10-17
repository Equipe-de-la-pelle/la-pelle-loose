-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE "pictures"
(
  id serial PRIMARY KEY,
  name VARCHAR(60) NOT NULL,
  path VARCHAR(128) NOT NULL
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE "pictures"
