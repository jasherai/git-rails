= git-rails

* http://blog.nanorails.com/git-rails

== DESCRIPTION:

Tools to help using git with rails

== FEATURES/PROBLEMS:

* create new git repository with .gitignore, linked to remote git repository
* install plugins from git source as git modules
* install plugins from svn source as git modules

== SYNOPSIS:

  git-rails init {remote git repository}
  git-rails install [remote plugin repository]
  git-rails update plugin-name

== REQUIREMENTS:

* git
* rails 2.0.2
* hoe 1.5.0
* main 2.8.0
* rake 0.8.1

== INSTALL:

* sudo gem install git-rails
