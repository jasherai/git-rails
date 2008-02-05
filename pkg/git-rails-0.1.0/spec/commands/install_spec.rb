require File.dirname(__FILE__) + '/../spec_helper.rb'

module GitRailsCommandsInstallHelper
end

describe "GitRails::Commands::Install" do
  include GitRailsCommandsInstallHelper
  include GitRails::SpecHelpers

  before(:each) do
    @init = GitRails::Commands::Init.new
    @install = GitRails::Commands::Install.new
    @project = tmppath(:project)
    @git = GitRails::Git.new
  end

  after(:each) do
    cleanup
  end

  it "should download remote url into vendor/plugins and add it as a submodule" do
    plugin = in_tmp_directory(tmppath(:plugin)) do
      create_file("pluginfile")
      @init.run(nil, 'commit message', true)
    end
    project = in_tmp_directory(@project) do
      create_file("testfile")
      @init.run(nil, 'commit message', true)
      @install.run(plugin, "plugin1")
      File.exists?(File.join("vendor", "plugins", "plugin1")).should == true
      File.exists?(File.join("vendor", "plugins", "plugin1", "pluginfile")).should == true
      @git.status.should match(/Changes to be committed/)
    end

  end

end
