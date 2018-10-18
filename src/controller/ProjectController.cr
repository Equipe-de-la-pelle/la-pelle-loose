include Project

class ProjectController
  def search(@inputProject: String)
    projects = Project.where(:title, :like, inputProject)

  end

  def fetchProjects(@id )
    if :id
      projects = Project.find :id
    else
      projects = Project.all
    end

  end
end
