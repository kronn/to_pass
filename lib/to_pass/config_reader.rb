require 'yaml'

module ToPass
  # The ConfigReader reads the given file from a YAML-file
  # into a Hash. All Strings in the Hash are converted into
  # symbols.
  #
  # Search locations are managed in ToPass::Directories
  class ConfigReader < FileReader
    def initialize(fn='config',dir=nil) # :nodoc:
      super
    end

    # as the ConfigReader is only intended to read the configuration
    # file, the name is fixed here.
    def self.load(fn = 'config')
      super
    end

    def load_from_file
      fn = super
      config = {}

      YAML.load_file(fn).each_pair do |key, value|
        config[key.to_sym] =  value.kind_of?(String) ? value.to_sym : value
      end

      config
    end
  end
end
