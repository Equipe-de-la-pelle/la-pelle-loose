module Models
  class Contact < Granite::Base
    adapter pg

    table_name contacts

    field name : String
    field url : String
  end
end
