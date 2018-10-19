require "../spec_helper"

describe "Project Specs" do
  it "All Projects" do

    project1 = {	"title"=>"Un projet magnifique 1","description"=>"Lorem ipsim lasum danem","short"=>"Lorem ipsum","email"=>""}
    project2 = {	"title"=>"Un projet magnifique 2","description"=>"Lorem ipsim lasum danem","short"=>"Lorem ipsum","email"=>""}

    post("/projects",headers: HTTP::Headers{"Content-Type"=>"application/json"}, body: project1.to_json )
    post("/projects",headers: HTTP::Headers{"Content-Type"=>"application/json"}, body: project2.to_json )

    get "/projects"
    projects = JSON.parse(response.body)["data"]

    projects.size.should eq 2
  end

    it "Find project #" do

      project_json = {	"title"=>"Un projet magnifique find","description"=>"Lorem ipsim lasum danem","short"=>"Lorem ipsum","email"=>""}
      post("/projects",headers: HTTP::Headers{"Content-Type"=>"application/json"}, body: project_json.to_json )
      id = JSON.parse(response.body)["data"]["id"]
      get "/projects/#{id}"
      project = JSON.parse(response.body)["data"]

      project["id"].should eq id
      project["title"].should eq "Un projet magnifique find"
      project["description"].should eq "Lorem ipsim lasum danem"
      project["short"].should eq "Lorem ipsum"
      project["email"].should eq ""

    end

    it "new project #1" do

      json_body = {	"title"=>"Un projet magnifique","description"=>"Lorem ipsim lasum danem","short"=>"Lorem ipsum","email"=>""}
      post("projects",headers: HTTP::Headers{"Content-Type"=>"application/json"}, body: json_body.to_json)

      project = JSON.parse(response.body)["data"]
      project["title"].should eq "Un projet magnifique"
      project["description"].should eq "Lorem ipsim lasum danem"
      project["short"].should eq "Lorem ipsum"
      project["email"].should eq ""


    end

    it "search project" do
      project1 = {	"title"=>"La pelle loose","description"=>"Lorem ipsim lasum danem","short"=>"Lorem ipsum","email"=>""}
      project2 = {	"title"=>"La pelle volante","description"=>"Lorem ipsim lasum danem","short"=>"Lorem ipsum","email"=>""}

      post("/projects",headers: HTTP::Headers{"Content-Type"=>"application/json"}, body: project1.to_json )
      post("/projects",headers: HTTP::Headers{"Content-Type"=>"application/json"}, body: project2.to_json )

      get "/projects/search/pelle"
      lespelles = JSON.parse(response.body)
      lespelles["count"].should eq 2


    end


    it "Delete #" do

      project_json = {	"title"=>"Un projet magnifique delete","description"=>"Lorem ipsim lasum danem","short"=>"Lorem ipsum","email"=>""}
      post("/projects",headers: HTTP::Headers{"Content-Type"=>"application/json"}, body: project_json.to_json )
      id = JSON.parse(response.body)["data"]["id"]

      delete "/projects/#{id}"
      (response.status_code == 200).should be_true
    end
end
