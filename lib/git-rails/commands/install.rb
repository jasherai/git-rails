module GitRails
  module Commands
    class Install < GitRails::Command

      def run(remote, plugin_name)
        git_sub_module = GitRails::Git::SubModule.new
        path = plugin_name.match('/') ? plugin_name : File.join("vendor", "plugins", plugin_name)
        git_sub_module.add(remote, path)
        git_sub_module.init
        git_sub_module.update
      end

    end
  end
end
