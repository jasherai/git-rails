module GitRails
  module Commands
    class Update < GitRails::Command

      def run(plugin_name)
        git = GitRails::Git.new
        Dir.chdir(File.join("vendor", "plugins", plugin_name)) do
          git.pull
        end
      end

    end
  end
end
