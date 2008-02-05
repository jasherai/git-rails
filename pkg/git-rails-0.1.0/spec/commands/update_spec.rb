require File.dirname(__FILE__) + '/../spec_helper.rb'

module GitRailsCommandsUpdateHelper
end

describe "GitRails::Commands::Update" do
  include GitRailsCommandsUpdateHelper
  include GitRails::SpecHelpers

  before(:each) do
    @init = GitRails::Commands::Init.new
    @install = GitRails::Commands::Install.new
    @update = GitRails::Commands::Update.new
    @project = tmppath(:project)
    @git = GitRails::Git.new
  end

  after(:each) do
    cleanup
  end

  it "should update changes to a plugin file" do
    plugin = in_tmp_directory(tmppath(:plugin)) do
      create_file("pluginfile")
      @init.run(nil, 'commit message', true)
    end
    in_tmp_directory(@project) do
      create_file("testfile")
      @init.run(nil, 'commit message', true)
      @install.run(plugin, "plugin1")
      File.exists?(File.join("vendor", "plugins", "plugin1")).should == true
      File.exists?(File.join("vendor", "plugins", "plugin1", "pluginfile")).should == true
      @git.commit_all('', {"-m" => "commit message"})
    end

    in_tmp_directory(plugin) do
      file = File.new("pluginfile", "w")
      file<< "make some changes\n"
      file.close
      @git.commit_all('', {"-m" => "commit change to pluginfile"})
    end
    
    in_tmp_directory(@project) do
      @update.run("plugin1")
      IO.read(File.join("vendor", "plugins", "plugin1", "pluginfile")).should match(/changes/)
    end
  end

end
