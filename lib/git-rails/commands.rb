module GitRails
  class Command

    attr_accessor :config, :svn, :git, :local

    def initialize(options = {})
      # @config = options["config"] || Giston::Config.new
      # @svn    = options["svn"]    || Giston::Svn.new
      # @git    = options["git"]    || Giston::Git.new
      # @local  = options["local"]  || Giston::Local.new
    end

    def self.run(command, *args)
      klass = GitRails::Commands.const_get(command.to_s.capitalize)
      klass.new.run(*args)
    rescue GitRails::Exception => e
      puts "git-rails: An exception has occured: #{e.message || e} (#{e})"
    end
    
    private
      def msg(str)
        puts "git-rails: " + str
      end
  end
end

require 'git-rails/commands/init'
require 'git-rails/commands/install'
require 'git-rails/commands/update'
