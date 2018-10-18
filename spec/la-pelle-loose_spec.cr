require "./spec_helper"

describe "La::Pelle::Loose" do
  it "All Projects" do
    get "/projects"

    projects = JSON.parse(response.body)["data"]

    (projects.size > 15 && projects.size < 30).should be_true
  end
end
