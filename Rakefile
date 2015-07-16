require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test

namespace :test do
  desc 'Build the test database'
  task :create_database do
    %x( createdb fakey_test )
  end

  desc 'Drop the test database'
  task :drop_database do
    %x( dropdb fakey_test )
  end

  desc 'Rebuild the test database'
  task :rebuild_database => [:drop_database, :create_database]
end