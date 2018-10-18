

module Service
  class ProjectService


    def search(input_project : String)
      Models::Project.where(:title, :like, "%#{input_project}%").select
    end

    def fetch_projects(id : String | Nil = nil )
      if id
        Models::Project.find id
      else
        Models::Project.all
      end
    end
  end
end
