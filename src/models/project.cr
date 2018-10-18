module Models
  class Project < Granite::Base
    adapter pg

    table_name projects

    primary id : Int32
    field title : String
    field description : String
    field short : String

    # has_one :picture

    has_many :user_projects, class_name: UserProject
    has_many :users, class_name: User, through: :user_projects
  end
end
