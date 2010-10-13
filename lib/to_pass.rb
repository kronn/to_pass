# vim:ft=ruby:fileencoding=utf-8

# setup the LoadPath
lib_path = File.expand_path('../', __FILE__)
if File.exist?(lib_path)
  $LOAD_PATH << lib_path unless $LOAD_PATH.include?(lib_path)
end

# Library to convert a String into a Password
#
# see README.rdoc for details
module ToPass
  autoload :VERSION,           'to_pass/version'
  autoload :DATE,              'to_pass/version'
  autoload :APP_NAME,          'to_pass/version'

  autoload :AlgorithmReader,   'to_pass/algorithm_reader'
  autoload :Base,              'to_pass/base'
  autoload :Cli,               'to_pass/cli.rb'
  autoload :Converter,         'to_pass/converter'
  autoload :ConverterReader,   'to_pass/converter_reader'
  autoload :Converters,        'to_pass/converters'
  autoload :Directories,       'to_pass/directories'
  autoload :Integration,       'to_pass/integration'
end
