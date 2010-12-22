# vim:ft=ruby:fileencoding=utf-8

require 'yaml'

module ToPass
  # The AlgorithmReader's primary API is to load the rules from a YAML-file
  # into a Hash.
  #
  # Algorithms are searched in a list of standard directories. Those are defined
  # and managed in ToPass::Directories
  #
  # see ToPass::Converter for usage of the loaded algorithm
  class AlgorithmReader < FileReader
    def initialize(algorithm) # :nodoc:
      super(algorithm, 'algorithms')
    end

    class << self
      def extension # :nodoc:
        'yml'
      end
    end

    def load_from_file # :nodoc:
      fn = super

      YAML.load_file(fn.expand_path)
    rescue LoadError
      raise LoadError, "algorithm #{@file} could not be found in #{load_path}" if fn.nil?
    end
  end
end
