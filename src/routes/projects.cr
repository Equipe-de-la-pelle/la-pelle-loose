options "/projects" do
end

options "/projects/:id/picture" do
end

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
    email = env.params.json["email"].as(String)

    project = Models::Project.new
    project.title = title
    project.description = description
    project.short = short
    project.email = email

    if project.save
      { data: project }.to_json
    else
      env.response.status_code = 422
      { error: project }.to_json
    end
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
  email = env.params.json["email"].as(String)

  project = Models::Project.find(env.params.url["id"])
  if project

    project.title = title
    project.description = description
    project.short = short
    project.email = email
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
        service = Service::Upload.new(project, "projects")
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

    raise Kemal::Exceptions::RouteNotFound.new(env) if picture.new_record?
    send_file env, picture.path.not_nil!
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end
