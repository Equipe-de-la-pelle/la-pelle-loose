require "../spec_helper"

describe "/users* routes" do
  describe "Index" do
    it "Get all users" do
      Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")
      Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")

      get "/users"

      users = JSON.parse(response.body)["data"]

      users.size.should eq 2
    end
  end

  describe "Show" do
    it "Get one user" do
      Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")
      find = Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")

      get "/users/#{find.id}"

      user = JSON.parse(response.body)["data"]

      user["first_name"].should eq find.first_name
      user["email"].should eq find.email
      user["last_name"].should eq find.last_name
      user["nickname"].should eq find.nickname
    end
  end

  describe "Picture" do
    describe "Upload" do
    end

    describe "Send" do
    end
  end

  describe "Create" do
    it "with all keys" do
      json_body = {"first_name" => "Testy", "last_name" => "McTestFace", "nickname" => "Billy", "email" => "testy@billy.ts"}
      post("users",headers: HTTP::Headers{"Content-Type"=>"application/json"} , body: json_body.to_json)

      user = JSON.parse(response.body)["data"]

      user["first_name"].should eq json_body["first_name"]
      user["email"].should eq json_body["email"]
      user["last_name"].should eq json_body["last_name"]
      user["nickname"].should eq json_body["nickname"]

      response.status_code.shoud eq 200
    end

    pending "with missing key" do
      json_body = {"first_name" => "Testy", "last_name" => "McTestFace"}
      post("users",headers: HTTP::Headers{"Content-Type"=>"application/json"} , body: json_body.to_json)

      error = JSON.parse(response.body)["data"]

      error["error"].should eq "not_found"

      response.status_code.shoud eq 500
    end
  end

  describe "Update" do
    it "with all keys" do
      json_body = {"first_name" => "Testy", "last_name" => "McTestFace", "nickname" => "Billy", "email" => "testy@billy.ts"}
      put("users",headers: HTTP::Headers{"Content-Type"=>"application/json"} , body: json_body.to_json)

      user = JSON.parse(response.body)["data"]

      user["first_name"].should eq json_body["first_name"]
      user["email"].should eq json_body["email"]
      user["last_name"].should eq json_body["last_name"]
      user["nickname"].should eq json_body["nickname"]
    end

    pending "with missing key" do
    end

    pending "user not existing" do
    end
  end

  describe "Delete" do
    pending "existing user" do
    end

    pending "missing user" do
    end
  end
end
