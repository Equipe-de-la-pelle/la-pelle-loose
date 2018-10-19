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
    pending "with all keys" do
    end

    pending "with missing key" do
    end
  end

  describe "Update" do
    pending "with all keys" do
    end

    pending "with missing key" do
    end
  end

  describe "Delete" do
    pending "existing user" do
    end

    pending "missing user" do
    end
  end
end
