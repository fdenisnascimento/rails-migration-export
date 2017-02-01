# frozen_string_literal: true
require 'bundler/gem_tasks'
$stdout.sync = true

desc 'Open Migration Export pry console'
task :console do
  require 'pry'
  require 'migration_export'

  ARGV.clear
  Pry.start
end
