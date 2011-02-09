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
        when *all.keys - [:standard]
          all[key]
        when :standard
          [ all[:user], all[:data], all[:source_data] ]
        when :all
          user_paths + [ all[:user], all[:data], all[:source_data] ]
        end
      end

      # a new path can be added to have a broader or specialised lookup
      def []=(key, value)
        add_user_key(key)

        all[key] = value
      end

      # checks wether the path is already known by value or key
      def include?(search)
        all.has_value?(search) || all.has_key?(search)
      end

      private

      # adds a new key to the list to distinguish user added keys from built in ones
      def add_user_key(key)
        (@user_keys ||= []) << key unless all.has_key?(key)
      end

      # return the array of user-supplied paths
      def user_paths
        @user_keys.map do |key|
          all[key]
        end.to_a
      end

      # list of all directories used by this project
      def all
        @all ||= {
          :user => "~/.#{APP_NAME}",
          :data => "#{ruby_data_dir}/#{APP_NAME}",
          :base => File.expand_path("#{File.dirname(__FILE__)}/../.."),
          :source_data => File.expand_path("#{File.dirname(__FILE__)}/../../data/#{APP_NAME}"),
        }
      end

      # retrieve the ruby data-dir from different version of ruby.
      #
      # The latter version is present in 1.8.7 p249/302
      def ruby_data_dir
        RbConfig::CONFIG['data-dir'] || RbConfig::CONFIG['datadir']
      end
    end
  end
end
