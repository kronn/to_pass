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
      if @options[:pipe_out]
        $stdout << @password
      else
        puts @password
      end
    end

    protected

    # parse the options
    def parse_options
      options = {
        :algorithm => 'basic_de',
        :pipe_out  => false,
        :pipe_in   => false
      }

      OptionParser.new do |opts|
        opts.banner = "Usage: #{__FILE__} [options] passphrase"
        opts.separator ""

        opts.on('-a', '--algorithm ALGORITM', "use specified algorithm for transformation") do |value|
          options[:algorithm] = value
        end

        opts.on('-p', '--[no-]pipe', "pipe result to stdout (without trailing linebreak)") do |value|
          options[:pipe_out] = value
        end

        opts.separator ""

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end.parse!

      if ARGV[0].nil?
        options[:pipe_in] = options[:pipe_out] = true
      end

      options
    end

    # get the input string
    def get_input_string
      unless @options[:pipe_in]
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
