-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE "user_has_project"
(

);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE "user_has_project"
