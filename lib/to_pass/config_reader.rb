require 'yaml'

module ToPass
  class ConfigReader < FileReader
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
