require File.dirname(__FILE__) + '/../spec_helper.rb'

module GitRailsCommandsInitHelper
end

describe "GitRails::Commands::Init" do
  include GitRailsCommandsInitHelper
  include GitRails::SpecHelpers

  before(:each) do
    @init = GitRails::Commands::Init.new
    @project = tmppath(:project)
    @git = GitRails::Git.new
  end

  after(:each) do
    cleanup
  end

  it "should create a .gitignore file in the current directory" do
    in_tmp_directory(@project) do
      create_file("testfile")
      @init.run(nil, '', false)
      File.exists?(".gitignore").should == true
      @git.status.should match(/new file:/)
    end
  end

  it "should commit when commit option is provided" do
    in_tmp_directory(@project) do
      create_file("testfile")
      @init.run(nil, 'commit message', true)
      @git.status.should match(/nothing to commit/)
    end
  end

  it "should not overwrite an existing .gitignore file" do
    in_tmp_directory(@project) do
      create_file(".gitignore")
      @init.run(nil, '', false)
      File.size(".gitignore").should == 0
    end
  end
  
  it "should create a tmp/.gitignore file and log/.gitignore" do
    in_tmp_directory(@project) do
      create_file("testfile")
      @init.run(nil)
      File.exists?("log/.gitignore").should == true
      File.exists?("tmp/.gitignore").should == true
    end
  end

  it "should link to remote repository if provided" do
    origin = in_tmp_directory(tmppath(:origin)) do
      @git.init
    end
    in_tmp_directory(@project) do
      create_file("testfile")
      @init.run(origin, 'commit message', true)
      @git.push("origin", "master")
    end
    in_tmp_directory(origin) do
      @git.log.should match(/commit/)
    end
  end
  
end
