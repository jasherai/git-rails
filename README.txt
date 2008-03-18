= git-rails:

* http://blog.nanorails.com/git-rails
* http://rubyforge.org/projects/git-rails/

== DESCRIPTION:

Tools to help using git with rails

== FEATURES/PROBLEMS:

* create new git repository with .gitignore, linked to remote git repository
* install plugins from git source as git modules
* install git source as a git module to any path
* install plugins from svn source as git modules

== SYNOPSIS:

  git-rails init {remote git repository}
  git-rails install <remote plugin repository> [plugin name||path]
  git-rails update <plugin-name||path>

== REQUIREMENTS:

* git
* rails 2.0.2
* hoe 1.5.0
* main 2.8.0
* rake 0.8.1
* rspec 1.1.3

== INSTALL:

* sudo gem install git-rails
