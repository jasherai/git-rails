module GitRails
  class Exception < StandardError
  end

  module Commands
  end

  class Git
    class LocalRepositoryHasUncommitedChanges < GitRails::Exception; end
    class RepositoryError < GitRails::Exception; end
  end
end
