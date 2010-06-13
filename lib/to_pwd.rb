# Library to convert a String into a Password
module ToPwd
  # version of gem, read directly from the VERSION-File
  VERSION = File.read(File.join(File.dirname(__FILE__), '../VERSION')).strip

  # name of gem
  APP_NAME = 'to_pwd'

  autoload :Converter,         'lib/to_pwd/converter'
  autoload :StringConversions, 'lib/to_pwd/string_conversions'
  autoload :Base,              'lib/to_pwd/base'
  autoload :Integration,       'lib/to_pwd/integration'
  autoload :AlgorithmReader,   'lib/to_pwd/algorithm_reader'
end
