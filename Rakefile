#!/usr/bin/env rake
require "bundler/gem_tasks"
#require "rake/version_task"
require "rake/testtask" 
require 'standalone_migrations'


#Rake::VersionTask.new

StandaloneMigrations::Tasks.load_tasks

task :default => [:test]

Rake::TestTask.new do |test|
  test.libs << "test" 
  test.test_files = Dir[ "test/test_*.rb" ]
  test.verbose = true
end
