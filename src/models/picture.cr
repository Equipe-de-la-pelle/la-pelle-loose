module Models
  class Picture < Granite::Base
    adapter mysql

    table_name picture

    field name : String
    field path : String
  end
end
