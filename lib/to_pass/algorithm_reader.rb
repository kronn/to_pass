# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require 'pathname'
require 'yaml'

module ToPass
  # The AlgorithmReader's primary API is to load the rules from a YAML-file
  # into a Hash.
  #
  # Algorithms are searched in a list of standard directories. Those are defined
  # and managed in ToPass::Directories
  #
  # see ToPass::Converter for usage of the loaded algorithm
  class AlgorithmReader
    attr_reader :load_path

    def initialize(algorithm) # :nodoc:
      @algorithm = algorithm
      @load_path = []
      ToPass::Directories[:standard].map do |dir|
        dir + '/algorithms'
      end.each do |dir|
        dir = Pathname.new(dir).expand_path
        @load_path << dir if dir.exist?
      end
    end

    class << self
      # load an algorithm with a given identifier
      def load(algorithm)
        new(algorithm).load_from_file
      end

      # searches for available algorithms
      def discover
        new(nil).load_path.collect do |dir|
          Dir["#{dir}/*.yml"]
        end.flatten.compact.map do |fn|
          File.basename(fn).gsub('.yml', '')
        end
      end
    end

    def load_from_file # :nodoc:
      fn = load_path.map do |dir|
        file = Pathname.new("#{dir}/#{@algorithm}.yml")

        if file.exist?
          file
        else
          next
        end
      end.compact.first

      raise LoadError, "algorithm #{@algorithm} could not be found in #{load_path}" if fn.nil?

      YAML.load_file(fn.expand_path)
    end
  end
end
