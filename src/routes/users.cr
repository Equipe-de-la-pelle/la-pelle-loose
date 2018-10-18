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

get "/users/:id/picture" do |env|
  user = Models::User.find!(env.params.url["id"])
  if user
    picture = user.picture

    pp picture

    if !picture.new_record?
      file_path = ::File.join ["uploads/users", picture.path.not_nil!]
      send_file env, file_path
    else
      { error: :error }.to_json
    end
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

put "/users/:id" do |env|
  nickname = env.params.json["nickname"].as(String)
  first_name = env.params.json["first_name"].as(String)
  last_name = env.params.json["last_name"].as(String)

  user = Models::User.find(env.params.url["id"])
  if user
    user.nickname = nickname
    user.first_name = first_name
    user.last_name = last_name
    user.save
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
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
  user = Models::User.find(env.params.url["id"])

  if user
    HTTP::FormData.parse(env.request) do |upload|
      if upload.filename && upload.body
        service = Service::Upload.new(user, "users")
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
