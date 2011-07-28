require 'rubygems'
require 'rake'

Gem::Specification.new do |s|
  s.name = "redmine_burndown"
  s.version = "1.1.3"
  s.author = "Dan Hodos"
  s.email = ""
  s.description = "Generates a simple Burndown chart for using Redmine in Scrum environments"
  s.homepage = "http://github.com/scrumalliance/redmine_burndown"
  s.platform = Gem::Platform::RUBY
  s.summary = "Centralized Projects Repository Management"
  s.files = FileList["*","{app,assets,db,lang,lib,test}/**/*"].to_a
  s.require_path = "lib"
  #s.autorequire = "name"
  s.test_files = FileList["{test}/**/*test.rb"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.markdown"]
  #s.add_dependency("dependency", ">= 0.x.x")
end
