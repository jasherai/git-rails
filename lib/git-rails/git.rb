module GitRails
  class Git

    def local_changes?(dir)
      dir ||= '.'
      out = sys('git-status | grep -e "#{dir}"')
      !out.empty?
    end

    def init
      Git::sys('git init')
    end

    def add(path)
      Git::sys('git add', path)
    end

    def commit_all(path='', options={})
      Git::sys('git commit -a', options.collect{|key,value| "#{key} #{value}"}.join(" "), path)
    end

    def push(dest, source)
      Git::sys('git push', dest, source)
    end

    def pull(remote='')
      Git::sys('git pull', remote)
    end

    def status()
      Git::sys('git status')
    end
    
    def log()
      Git::sys('git log')
    end
    
    class SubModule
      def add(source_url, dest_path)
        ::GitRails::Git::sys('git submodule add', source_url, dest_path)
      end
      def init
        ::GitRails::Git::sys('git submodule init')
      end
      def update(path='')
        ::GitRails::Git::sys('git submodule update')
      end
    end

    protected
      def self.sys(*args)
        `#{args.join(' ')}`
      end
  end
end

