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

    raise Kemal::Exceptions::RouteNotFound.new(env) if picture.new_record?
    send_file env, picture.path.not_nil!
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

put "/users/:id" do |env|
  nickname = env.params.json["nickname"].as(String)
  first_name = env.params.json["first_name"].as(String)
  last_name = env.params.json["last_name"].as(String)
  email = env.params.json["email"].as(String)

  user = Models::User.find(env.params.url["id"])
  if user
    user.nickname = nickname
    user.first_name = first_name
    user.last_name = last_name
    user.email = email
    user.save
    {data: user}.to_json
  else
    raise Kemal::Exceptions::RouteNotFound.new(env)
  end
end

post "/users" do |env|
  nickname = env.params.json["nickname"].as(String)
  first_name = env.params.json["first_name"].as(String)
  last_name = env.params.json["last_name"].as(String)
  email = env.params.json["email"].as(String)

  user = Models::User.new
  user.nickname = nickname
  user.first_name = first_name
  user.last_name = last_name
  user.email = email
  user.save
  {data: user}.to_json

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
