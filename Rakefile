# frozen_string_literal: true

require "bundler/gem_tasks"
require "bundler"
Bundler.setup
Bundler::GemHelper.install_tasks

require "rake"
require "yaml"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec
