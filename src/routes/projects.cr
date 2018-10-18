get "/projects" do |env|
  projects = Models::Project.all

  if projects
    { data: projects, count: projects.size }.to_json
  end
end

post "/projects" do |env|
    title = env.params.json["title"].as(String)
    description = env.params.json["description"].as(String)
    short = env.params.json["short"].as(String)

    # Models::Project.create(title: "#{title}", description: "#{description}", short: "#{short}")
        project = Models::Project.new
        project.title = title
        project.description = description
        project.short = short
        project.save
        {data: project}.to_json

end

get "/projects/search/:search" do |env|
  projects = Service::ProjectService.new.search(env.params.url["search"])
  if projects
    { data: projects, count: projects.size }.to_json
  else
      raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

get "/projects/:id" do |env|
  #project = Models::Project.find(env.params.url["id"])
  project = Service::ProjectService.new.fetch_projects(env.params.url["id"])

  if project
    { data: project }.to_json
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

put "/projects/:id" do |env|
  title = env.params.json["title"].as(String)
  description = env.params.json["description"].as(String)
  short = env.params.json["short"].as(String)

  project = Models::Project.find(env.params.url["id"])
  if project

    project.title = title
    project.description = description
    project.short = short
    project.save
    {data: project}.to_json
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

delete "/projects/:id" do |env|

  project = Models::Project.find(env.params.url["id"])
  if project
    project.destroy
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

post "/projects/:id/picture" do |env|
  project = Models::Project.find(env.params.url["id"])

  if project
    HTTP::FormData.parse(env.request) do |upload|
      if upload.filename && upload.body
        service = Service::Upload.new(project)
        service.call(
          upload.filename.not_nil!,
          upload.body.not_nil!
        )
      end
    end

    { upload: :ok }.to_json
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

get "/projects/:id/picture" do |env|

  project = Models::Project.find!(env.params.url["id"])

  if project
    picture = project.picture

    if !picture.new_record?
      pp picture
      file_path = ::File.join ["uploads/projects", picture.path.not_nil!]
      send_file env, file_path
    else
      raise Kemal::Exceptions::RouteNotFound.new(env)
    end
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end
