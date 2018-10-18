include Project

class ProjectService
  def search(inputProject: String)
    projects = Project.where(:title, :like, inputProject)

  end

  def fetchProjects(id: Int32 | Nil:nil )
    if id
      projects = Project.find id
    else
      projects = Project.all
    end

  end
end
