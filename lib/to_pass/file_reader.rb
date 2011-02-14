# vim:fileencoding=utf-8
# require 'pathname'
# require 'yaml'

require 'pathname'

module ToPass
  # a generic Filereader, abstracting (among others) ToPass::AlgorithmReader
  # and ToPass::ConverterReader.
  #
  # Files are searched in a list of standard directories. Those are defined
  # and managed in ToPass::Directories
  class FileReader
    attr_reader :load_path

    def initialize(file = nil, dir_suffix = nil) # :nodoc:
      @file = file
      @load_path = []

      @load_path.concat(standard_directories(dir_suffix))
    end

    class << self
      # load a file with a given identifier
      def load(fn)
        new(fn).load_from_file
      end

      # searches for available algorithms
      def discover
        extension = ".#{extension}" if extension

        new(nil).load_path.collect do |dir|
          Dir["#{dir}/#{search_pattern}#{extension}"]
        end.flatten.compact.map do |fn|
          File.basename(fn).gsub('#{extension}', '')
        end
      end

      def search_pattern
        '*'
      end

      def extension
        nil
      end
    end

    def load_from_file # :nodoc:
      fn = load_path.map do |dir|
        extension = ".#{self.class.extension}" if self.class.extension
        file = Pathname.new("#{dir}/#{@file}#{extension}")

        if file.exist?
          file
        else
          next
        end
      end.compact.first

      raise LoadError, "file #{@file} could not be found in #{load_path}" if fn.nil?

      fn
    end

    private

    def standard_directories(suffix = nil)
      suffix = suffix.to_s
      suffix = "/#{suffix}" unless suffix =~ /^\//

      ToPass::Directories[:all].map do |dir|
        dir.to_s + suffix
      end.map do |dir|
        dir = Pathname.new(dir).expand_path
        dir if dir.exist?
      end.compact
    end
  end
end
