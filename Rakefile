# frozen_string_literal: true

require 'bundler/setup'
require 'rake'
require 'padrino-core/cli/rake'
require 'English'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RACK_ENV = ENV['RACK_ENV'] ||= 'test' unless defined?(RACK_ENV)

PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init

task :all do
  ['rubocop', 'rake spec'].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
  end
end

task :build_server do
  ['rake spec_report'].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
  end
end

Cucumber::Rake::Task.new(:cucumber) do |task|
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed'].invoke
  task.cucumber_opts = ['features', '--tags ~@wip']
end

Cucumber::Rake::Task.new(:cucumber_report) do |task|
  Rake::Task['db:migrate'].invoke
  task.cucumber_opts = ['features', '--format html -o reports/cucumber.html']
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --format d'
end

RSpec::Core::RakeTask.new(:spec_report) do |t|
  t.pattern = './spec/**/*_spec.rb'
  t.rspec_opts = %w[--format RspecJunitFormatter --out reports/spec/spec.xml]
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['--display-cop-names']
  task.requires << 'rubocop-rspec'
end

task default: %i[spec rubocop]
