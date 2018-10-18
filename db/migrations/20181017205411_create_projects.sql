-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE "projects"
(
  id serial PRIMARY KEY,
  title VARCHAR(60) NOT NULL,
  description VARCHAR(3000) NOT NULL,
  short VARCHAR(200) NOT NULL
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE "projects"
