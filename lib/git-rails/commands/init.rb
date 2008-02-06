require 'fileutils'

module GitRails
  module Commands
    class Init < GitRails::Command
      def run(remote, message='', commit=false)
        ignore(".", ".DS_Store")
        ignore("config", "database.yml")
        ignore("db", ["*.db", "*.sqlite*"])
        ignore("log", "*.log")
        ignore("tmp", "[^.]*")
        ignore("public/cache", "[^.]*")
        ignore("doc", ["api","app"])

        git = GitRails::Git.new
        git.init
        git.add(".")
        git.commit_all('', message ? {"-m" => "\"#{message}\""} : {}) if commit
        if (remote)
          config = File.new(".git/config", "a")
          config << "[remote \"origin\"]\n"
          config << "        url = #{remote}\n"
          config << "        fetch = +refs/heads/*:refs/remotes/origin/*\n"
          config << "[branch \"master\"]\n"
          config << "        remote = origin\n"
          config << "        merge = refs/heads/master\n"
          config.close
          puts "You can now push to the origin #{remote} by using:\n"
          puts "  git push origin master\n"
        end
      end
    private
      def ignore(path, entries)
        file = path + "/.gitignore"
        unless File.exists?(file)
          FileUtils.mkdir_p(path)
          handle = File.new(file, "w")
          entries.each do |entry|
            handle << "#{entry}\n"
          end
          handle.close
        end
      end
    end
  end
end
