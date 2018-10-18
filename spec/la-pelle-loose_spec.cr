require "./spec_helper"
require "logger"

logger = Logger.new(STDOUT,level: Logger::WARN)

describe "La::Pelle::Loose" do
  # TODO: Write tests

  # it "works" do
  #   false.should eq(true)
  # end

  it "All Projects" do
    get "/projects" do
    end

    projects = JSON.parse(response.body.data)

    {projects.size > 15 && projects.size < 30}.should be_true
  end
end
