module Models
  class User < Granite::Base
    adapter mysql

    table_name user

    field nickname : String
    field first_name : String
    field last_name : String
    field token : String

    has_one :picture

    has_many :user_projects, class_name: UserProject
    has_many :projects, class_name: Project, through: :user_projects
  end
end
