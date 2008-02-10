require 'fileutils'

module GitRails
  module Commands
    class Init < GitRails::Command
      def run(remote, message='', commit=false, include_database_yaml=false)
        ignore(".", ".DS_Store")
        ignore("db", "*.sqlite3")
        ignore("log", "*.log")
        ignore("tmp", "[^.]*")
        ignore("public/cache", "[^.]*")
        ignore("doc", ["api","app"])

        unless include_database_yaml then
          ignore("config", "database.yml")
        end

        unless sqlite_by_default then
          sqlite = File.new("config/database.sqlite.yml", "w")
          sqlite << "development:\n"
          sqlite << "  adapter: sqlite3\n"
          sqlite << "  dbfile: db/development.sqlite3\n"
          sqlite << "  timeout: 5000\n\n"
          sqlite << "test:\n"
          sqlite << "  adapter: sqlite3\n"
          sqlite << "  dbfile: db/test.sqlite3\n"
          sqlite << "  timeout: 5000\n\n"
          sqlite << "production:\n"
          sqlite << "  adapter: sqlite3\n"
          sqlite << "  dbfile: db/production.sqlite3\n"
          sqlite << "  timeout: 5000\n\n"
          sqlite.close
          if File.exists?("config/database.yml")
            FileUtils.mv("config/database.yml", "config/database.mysql.yml")
          end
          FileUtils.ln_sf("database.sqlite.yml", "config/database.yml")
        end

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

      def sqlite_by_default
        begin
          require 'config/boot.rb'
          # TODO: Make this less nasty.
          rails_version = Rails::VERSION::STRING.scan(/(\d)/).flatten.to_s.to_i
          rails_version <= 202          
        rescue LoadError
          true
        end
      end
    end
  end
end
