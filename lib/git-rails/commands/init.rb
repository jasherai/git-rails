module GitRails
  module Commands
    class Init < GitRails::Command

      def run(remote, message='', commit=false)
        unless File.exists?(".gitignore")
          gitignore = File.new(".gitignore", "w")
          gitignore << "log/*.log\n"
          gitignore << "tmp/**/*\n"
          gitignore << ".DS_Store\n"
          gitignore << "public/cache/**/*\n"
          gitignore << "doc/api\n"
          gitignore << "doc/app\n"
          gitignore.close
        end
        FileUtils.mkdir_p("log")
        gitignore = File.new("log/.gitignore", "w")
        gitignore.close
        FileUtils.mkdir_p("tmp")
        gitignore = File.new("tmp/.gitignore", "w")
        gitignore.close
        
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

    end
  end
end
