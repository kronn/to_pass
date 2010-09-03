# vim:ft=ruby:fileencoding=utf-8

require 'rbconfig'

module ToPass
  # Wrapper for the search directories. Primary purpose is to keep the dirty
  # part in one place instead of scattered throughout the project.
  #
  # Used by ToPass::AlgorithmReader and ToPass::ConverterReader
  class Directories
    class << self
      # get a directory or a list of directories
      def [](key)
        case key
        when :user, :data, :base, :source_data
          all[key]
        when :standard
          [ all[:user], all[:data], all[:source_data] ]
        end
      end

      private

      # list of all direcotries used by this project
      def all
        {
          :user => "~/.#{APP_NAME}",
          :data => "#{RbConfig::CONFIG['data-dir']}/#{APP_NAME}",
          :base => File.expand_path("#{File.dirname(__FILE__)}/../.."),
          :source_data => File.expand_path("#{File.dirname(__FILE__)}/../../data/#{APP_NAME}"),
        }
      end
    end
  end
end
