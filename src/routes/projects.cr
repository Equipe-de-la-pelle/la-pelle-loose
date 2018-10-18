get "/projects" do |env|
  projects = Models::Project.all

  if projects
    { data: projects, count: projects.size }.to_json
  end
end

post "/projects" do |env|
end

get "/projects/search/:search" do |env|
end

get "/projects/:id" do |env|
  project = Models::Project.find(env.params.url["id"])

  if project
    { data: project }.to_json
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

put "/projects/:id" do |env|
  project = Models::Project.find(env.params.url["id"])

  pp project

  if project
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

delete "/projects/:id" do |env|
end

post "/projects/:id/picture" do |env|
end
