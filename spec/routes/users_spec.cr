require "../spec_helper"

describe "/users* routes" do
  describe "Index" do
    it "Get all users" do
      Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")
      Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")

      get "/users"

      users = JSON.parse(response.body)["data"]

      users.size.should eq 2

      response.status_code.should eq 200
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

      response.status_code.should eq 200
    end
  end

  describe "Picture" do
    describe "Upload" do
      pending "without old photo" do
      end

      pending "with old photo" do
      end
    end

    describe "Send" do
      it "with photo" do
        find = Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")
        picture = find.picture
        picture.name = "pixel"
        picture.path = "./spec/fixtures/pixel.png"
        picture.save
        find.picture_id = picture.id
        find.save

        get "/users/#{find.id}/picture"

        response.status_code.should eq 200
      end

      it "without photo" do
        find = Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")

        get "/users/#{find.id}/picture"

        error = JSON.parse(response.body)["error"]

        error.should eq "not_found"
        response.status_code.should eq 404
      end
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
    it "existing user" do
      find = Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")

      delete "/users/#{find.id}"

      response.status_code.should eq 200
    end

    it "missing user" do
      delete "/users/999"

      response.status_code.should eq 404
    end
  end
end
