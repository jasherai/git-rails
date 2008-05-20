module GitRails
  module Commands
    class Update < GitRails::Command

      def run(plugin_name)
        git = GitRails::Git.new
	path = plugin_name.match('/') ? plugin_name : File.join("vendor", "plugins", plugin_name)
	version = git.version.split(' ').last
	remote="origin/master"
        Dir.chdir(path) do
          git.remote_update
	  git.merge(remote)
        end
      end

    end
  end
end
