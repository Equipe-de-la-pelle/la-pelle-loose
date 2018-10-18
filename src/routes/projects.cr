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

    # Models::Project.create(title: "#{title}", description: "#{description}", short: "#{short}")
        project = Models::Project.new
        project.title = title
        project.description = description
        project.short = short
        project.email = email
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
  pp project

  if project
    HTTP::FormData.parse(env.request) do |upload|
      filename = upload.filename

      if !filename.is_a?(String)
        { error: "Filename is missing" }.to_json
      else
        file_path = ::File.join ["uploads/projects", filename]

        picture = project.picture

        if !picture.new_record? && picture.path
          File.delete(picture.path.not_nil!)
        end

        picture.name = filename
        picture.path = file_path

        picture.save

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
      raise Kemal::Exceptions::RouteNotFound.new(env)
    end
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end
