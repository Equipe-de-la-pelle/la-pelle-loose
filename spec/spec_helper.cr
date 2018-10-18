require "spec"
require "spec-kemal"
require "../src/la-pelle-loose"

Spec.before_each do
  Models::Contact.migrator.drop_and_create
  Models::Project.migrator.drop_and_create
  Models::UserProject.migrator.drop_and_create
  Models::User.migrator.drop_and_create
  Models::Picture.migrator.drop_and_create
end
