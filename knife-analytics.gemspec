$:.unshift(File.dirname(__FILE__) + '/lib')

Gem::Specification.new do |s|
  s.name = "knife-analytics"
  s.version = '0.2.1'
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.summary = "Knife plugin for the Chef analytics platform"
  s.description = "Knife plugin for the Chef analytics platform."
  s.license = "Apache 2"
  s.author = "Chef Software, Inc."
  s.email = "info@getchef.com"
  s.homepage = "https://github.com/chef/knife-analytics"

  s.add_dependency "chef-analytics", "~> 0.1"

  s.require_path = 'lib'
  s.files = %w(LICENSE README.md Rakefile) + Dir.glob("{lib,spec}/**/*")
end

