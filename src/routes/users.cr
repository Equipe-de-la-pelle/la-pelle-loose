get "/users" do |env|
  # users = User.all
  #
  # if users
  #   users.to_json
  # end
end

get "/users/:id" do |env|
  # user = User.find(env.params.url["id"])
  #
  # if user
  #   user.to_json
  # else
  #   halt env, status_code: 404, response: "Not Found"
  # end
end

put "/users/:id" do |env|
end

delete "/users/:id" do |env|
end

post "/users/:id/picture" do |env|
end
