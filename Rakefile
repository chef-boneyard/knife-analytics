#
# Copyright:: Copyright (c) 2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'bundler'
require 'rubygems'
# Workaround for rake 10.0.4/Ruby 1.9.2p290 rdoc collision
# https://github.com/jimweirich/rake/issues/157
gem 'rdoc', ">= 2.4.2"
require 'rdoc/task'

Bundler::GemHelper.install_tasks

task :default => :install

gem_spec = eval(File.read("knife-analytics.gemspec"))

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "knife-analytics #{gem_spec.version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

