get "/users" do |env|
  users = Models::User.all

  if users
    { data: users, count: users.size }.to_json
  end
end

get "/users/:id" do |env|
  user = Models::User.find(env.params.url["id"])

  if user
    { data: user }.to_json
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

put "/users/:id" do |env|
end

delete "/users/:id" do |env|
end

post "/users/:id/picture" do |env|
end
