module Models
  class Picture < Granite::Base
    adapter pg

    table_name pictures

    field name : String
    field path : String
  end
end
