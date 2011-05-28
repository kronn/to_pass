# vim:ft=ruby
unless defined?(Watchr)
  require 'rubygems'
  require 'watchr'
end

# helper methods
def run_all
  exit() if @wants_to_quit
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
watch '^data/to_pass/config' do |m|
  single_or_all("test/test_configs.rb")
end
watch '^test/(helper|all).rb' do |m|
  run_all
end

# simple mappings
watch '^lib/to_pass/(.*).rb',  &single_test
watch '^test/test_(.*).rb', &single_test

# signals
Signal.trap 'QUIT' do
  abort('\n')
end

@interrupted = false
@wants_to_quit = false

Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_all
  end
end
