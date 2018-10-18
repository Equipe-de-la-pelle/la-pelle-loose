get "/projects" do |env|
  projects = Models::Project.all

  if projects
    { data: projects, count: projects.size }.to_json
  end
end

post "/projects" do |env|
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
  project = Models::Project.find(env.params.url["id"])

  if project
    # project.title = env.params.json["title"].as(String)
    # project.description = env.params.json["description"].as(String)
    # project.short = env.params.json["short"].as(String)

    # project.save
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

delete "/projects/:id" do |env|
end

post "/projects/:id/picture" do |env|
  project = Models::Project.find(env.params.url["id"])

  if project
    HTTP::FormData.parse(env.request) do |upload|
      filename = upload.filename

      if !filename.is_a?(String)
        { error: "Filename is missing" }.to_json
      else
        file_path = ::File.join ["uploads/projects", filename]

        picture = Models::Picture.new
        picture.name = filename
        picture.path = file_path

        picture.save

        pp project.picture

        if project_picture = project.picture
          pp project_picture
          File.delete(picture.path.not_nil!)
          pp project_picture.destroy
        end

        project.picture_id = picture.id
        pp project.save

        File.open(file_path, "w") do |f|
          IO.copy(upload.body, f)
        end

        { upload: :ok }.to_json
      end
    end
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
      { error: :error }.to_json
    end
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end
