begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  #gem 'rspec'
  require 'spec'
end

dir = File.dirname(__FILE__)
lib_path = File.expand_path("#{dir}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

require 'git_rails'

require "logger"
require "fileutils"

$logger = Logger.new($stderr)
$logger.level = Logger::INFO unless $DEBUG

module GitRails
  module SpecHelpers
    def logger
      $logger
    end

    def create_file(path)
      file = File.new(path, "w")
      file.close
      file
    end

    def tmppath(*paths)
      parts = [File.dirname(__FILE__), "tmp"]
      parts << (@root_time ||= Time.now.to_i.to_s)
      parts += paths
      # parts << rand().to_s.split(".").last
      parts.collect! {|path| path.to_s}
      path = File.join(*parts)
      attempts = 10
      while File.exists?(path)
        path.succ!
        attempts -= 1
        raise "Unable to find a good temp pathname: #{path.inspect}" if attempts.zero?
      end

      File.expand_path(path)
    end

    def cleanup
      path = File.expand_path(File.join(File.dirname(__FILE__), "tmp"))
      logger.debug {"Removing #{path.inspect}"}
      FileUtils.rm_rf(path)
    end
    
    def in_tmp_directory(path)
      FileUtils.mkdir_p(path)
      Dir.chdir(path) do
        yield
      end
      path
    end
  end
end
