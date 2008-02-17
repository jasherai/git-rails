module GitRails
  module Commands
    class Update < GitRails::Command

      def run(plugin_name)
        git = GitRails::Git.new
	path = plugin_name.match('/') ? plugin_name : File.join("vendor", "plugins", plugin_name)
        Dir.chdir(File.join(path, plugin_name)) do
          git.pull
        end
      end

    end
  end
end
