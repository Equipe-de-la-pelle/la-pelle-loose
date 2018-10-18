-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

ALTER TABLE "users"
ADD COLUMN picture_id INTEGER NULL,
ADD CONSTRAINT fk_user_picture FOREIGN KEY (picture_id) REFERENCES pictures(id);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
