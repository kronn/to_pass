# -*- coding: utf-8 -*-
# vim:ft=ruby:enc=utf-8

require 'optparse'

module ToPass
  # ToPass::Cli wraps the ugly code needed for option-parsing an such
  #
  # The default values for the options can be passed in to make different
  # executables behave differently.
  class Cli
    # creates a new Cli-wrapper for option-parsing and such. Almost everthing
    # needed is done inside the initalizer.
    #
    # The default options can be overriden. Defaults are:
    #
    #   options = {
    #     :algorithm => 'basic_de',
    #     :pipe_out  => false,
    #     :pipe_in   => false
    #   }
    #
    def initialize(options = {})
      @options =  parse_options(options)
      @string =   get_input_string
      @password = transform
    end

    # output the result of the string transformation
    def output
      if @options[:pipe_out]
        $stdout << @password
      else
        puts @password
      end
    end

    protected

    # parse the options
    def parse_options(options = {})
      options = {
        :algorithm => 'basic_de',
        :pipe_out  => false,
        :pipe_in   => false
      }.merge(options)

      OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options] passphrase"
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
