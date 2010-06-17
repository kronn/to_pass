# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require 'optparse'

module ToPass
  class Cli
    def initialize
      @options =  parse_options
      @string =   get_input_string
      @password = transform
    end

    def output
      if @options[:pipe_usage]
        $stdout << @password
      else
        puts @password
      end
    end

    protected

    # parse the options
    def parse_options
      options = {
        :algorithm  => 'basic_de'
      }

      OptionParser.new do |opts|
        opts.banner = "Usage: #{__FILE__} [options] passphrase"
        opts.separator ""

        opts.on('-a', '--algorithm ALGORITM', "use specified algorithm for transformation") do |value|
          options[:algorithm] = value
        end

        opts.separator ""

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end.parse!

      options[:pipe_usage] = ARGV[0].nil?

      options
    end

    # get the input string
    def get_input_string
      unless @options[:pipe_usage]
        ARGV[0]
      else
        $stdin.read.chomp
      end
    end

    # perform "heavy" work
    def transform
      Base.new( @string, @options[:algorithm] ).to_s
    end
  end
end
