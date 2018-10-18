module Models
  class Contact < Granite::Base
    adapter pg

    table_name contacts

    primary id : Int32
    field name : String
    field url : String
  end
end
