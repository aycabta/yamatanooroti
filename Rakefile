require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.loader = :direct
  t.pattern = 'test/yamatanooroti/**/test_*.rb'
end

task default: :test
