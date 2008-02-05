require File.dirname(__FILE__) + '/spec_helper.rb'

describe "GitRails::Git" do
  include GitRails::SpecHelpers
  
  before(:each) do
    @git = GitRails::Git.new
    @project = tmppath(:project)
  end
  
  after(:each) do
    cleanup
  end

  it "should create a .git directory when calling init" do
    in_tmp_directory(@project) do
      File.exists?(".git").should == false
      @git.init
      File.exists?(".git").should == true
    end
  end

  it "should add files in local project" do
    in_tmp_directory(@project) do
      create_file("test")
      @git.init
      @git.add(".")
      @git.status.should match(/new file: test/)
    end
  end

  it "should commit" do
    in_tmp_directory(@project) do
      create_file("testfile")
      @git.init
      @git.add(".")
      output = @git.commit_all('', {"-m" => "commit message"})
      output.should match(/Created initial commit/)
      output.should match(/testfile/)
    end
  end

end

describe "GitRails::Git::SubModule" do
  include GitRails::SpecHelpers
  
  before(:each) do
    @git = GitRails::Git.new
    @git_sub_module = GitRails::Git::SubModule.new
    @project = tmppath(:project)
  end
  
  after(:each) do
    cleanup
  end
  
  it "should add a module and initialize .gitmodules" do
    sub_project = in_tmp_directory(tmppath(:sub_project)) do
      create_file("testfile")
      @git.init
      @git.add(".")
      @git.commit_all('', {"-m" => "commit message"})
    end
    in_tmp_directory(@project) do
      @git.init
      @git_sub_module.add(sub_project, "./sub_project")
      @git_sub_module.init
      @git_sub_module.update
      File.exists?(".gitmodules").should == true
      File.exists?("sub_project/testfile").should == true
    end
  end
end