module Models
  class Project < Granite::Base
    adapter pg

    table_name projects

    field title : String
    field description : String

    has_one :picture

    has_many :user_projects, class_name: UserProject
    has_many :users, class_name: User, through: :user_projects
  end
end
