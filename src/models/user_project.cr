module Models
  class UserProject < Granite::Base
    adapter pg

    table_name user_has_project

    belongs_to :user
    belongs_to :project
  end
end
