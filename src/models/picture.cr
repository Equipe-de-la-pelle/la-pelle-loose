module Models
  class Picture < Granite::Base
    adapter pg

    table_name pictures

    primary id : Int32
    field name : String
    field path : String
  end
end
