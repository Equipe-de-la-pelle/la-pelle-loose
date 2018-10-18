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
  nickname = env.params.json["nickname"].as(String)
  first_name = env.params.json["first_name"].as(String)
  last_name = env.params.json["last_name"].as(String)
end

delete "/users/:id" do |env|
  user = Models::User.find(env.params.url["id"])
  if user
    user.destroy
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

post "/users/:id/picture" do |env|
  HTTP::FormData.parse(env.request) do |upload|
    filename = upload.filename

    if !filename.is_a?(String)
      { error: "Filename is missing" }.to_json
    else
      file_path = ::File.join ["uploads/users", filename]
      File.open(file_path, "w") do |f|
        IO.copy(upload.body, f)
      end
    end
  end
end
