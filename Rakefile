# optional libraries
%w[ redgreen ].each do |lib|
  begin
    require lib
  rescue LoadError
  end
end

# # enable trace to get better error output
# Rake.application.options.trace = true

task :default => [:test]

task :test do
  ( ['test/unit', 'test/helper'] + Dir['test/test_*.rb'] ).each do |file|
    require file
  end
end
