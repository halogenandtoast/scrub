require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "scrub"
    gemspec.summary = "Scrub files with ease and elbow grease"
    gemspec.description = "Scrub files with ease and elbow grease"
    gemspec.email = "matt@toastyapps.com"
    gemspec.homepage = "http://github.com/toastyapps/scrub"
    gemspec.authors = ["Matthew Mongeau"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

Rake::TestTask.new do |t|
  t.libs = %w(test)
  t.pattern = 'test/**/*_test.rb'
end

task :default => :test