module Models
  class User < Granite::Base
    adapter pg

    table_name users

    primary id : Int32
    field nickname : String
    field first_name : String
    field last_name : String
    field email : String
    field token : String?

    belongs_to :picture, foreign_key: picture_id : Int32?

    # has_many :user_projects, class_name: UserProject
    # has_many :projects, class_name: Project, through: :user_projects
  end
end
