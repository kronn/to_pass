# vim:ft=ruby
require 'rubygems'
require 'watchr'

# helper methods
def run_all
  puts "\rrunning all tests. Hit CTRL-\\ to quit."
  sleep(1)
  system "ruby test/all.rb"
end
def single_or_all(fn)
  clear_screen
  if File.exist?(File.expand_path(fn))
    system "ruby -Ilib -Itest #{fn}"
  else
    run_all
  end
end
def clear_screen
  system "clear"
end

# test_runner-lambda
single_test = lambda { |m|
  single_or_all("test/test_#{m[1]}.rb")
}

# specific mappings
watch '^data/to_pass/(algorithms|converters)/*.rb' do |m|
  single_or_all("test/test_#{m[1]}.rb")
end
watch '^data/config' do |m|
  single_or_all("test/test_configs.rb")
end

# simple mappings
watch '^lib/to_pass/(.*).rb',  &single_test
watch '^test/test_(.*).rb', &single_test

Signal.trap 'QUIT' do
  abort("\n")
end
Signal.trap 'INT' do
  run_all
end
