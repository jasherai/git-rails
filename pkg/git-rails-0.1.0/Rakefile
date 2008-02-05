# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/git_rails.rb'

Hoe.new('git-rails', GitRails::VERSION::STRING) do |p|
  p.rubyforge_name = 'git-rails'
  p.author = 'Pascal Belloncle (nano RAILS)'
  p.email = 'psq@nanorails.com'
  p.summary = 'Tools to make using git with rails a breeze'
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.extra_deps << ['main', '>= 2.8.0']
end

# vim: syntax=Ruby
