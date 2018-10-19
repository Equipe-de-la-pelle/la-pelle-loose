require "./spec_helper"


describe "La::Pelle::Loose" do
  it "All Projects" do
    get "/projects"

    projects = JSON.parse(response.body)["data"]

    (projects.size > 0 && projects.size < 10).should be_true
  end

  it "Find project #53" do
    get "/projects/53"

    project = JSON.parse(response.body)
    if project["error"] == nil
      project["data"]["id"].should eq 53
      project["data"]["title"].should eq "Un projet magnifique XXX :)"
      project["data"]["description"].should eq "Lorem ipsim lasum danem"
      project["data"]["short"].should eq "Lorem ipsum"
      project["data"]["email"].should eq ""
    else
      project["error"].should eq "not_found"
    end
  end

  it "new project #1" do
    post "/projects" do |env|
      env.params.json.to_json
    end

    json_body = {	"title"=>"Un projet magnifique","description"=>"Lorem ipsim lasum danem","short"=>"Lorem ipsum","email"=>""}
    post("projects",headers: HTTP::Headers{"Content-Type"=>"application/json"}, body: json_body.to_json)

    project = JSON.parse(response.body)["data"]
    project["title"].should eq "Un projet magnifique"
    project["description"].should eq "Lorem ipsim lasum danem"
    project["short"].should eq "Lorem ipsum"
    project["email"].should eq ""


  end


  it "Delete #1" do
    delete "/projects/1"
    (response.status_code == 200 || response.body["error"] != nil).should be_true
  end


  it "Get all users" do
    Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")
    Models::User.create(nickname: "Foo", first_name: "Fight", last_name: "Eursse", email: "foo@bar.co")

    get "/users"

    users = JSON.parse(response.body)["data"]

    users.size.should eq 2
  end

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
