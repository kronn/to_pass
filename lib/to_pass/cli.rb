# vim:ft=ruby:fileencoding=utf-8

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
    # If you want to override always, you can create a config file with the
    # following name:
    #
    #   ~/.to_pass/config
    #
    # The file is expected to be a YAML-File. Keys and values are transformed
    # symbols automatically. See ToPass::ConfigReader for details.
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

    class << self
      # output list of algorithms
      def algorithms
        puts ""
        puts "  available password algorithms"
        puts "  ============================================"
        AlgorithmReader.discover.each do |algorithm|
          puts "  - #{algorithm}"
        end
        puts "  ============================================"
        puts ""
      end

      # output list of converters
      def converters
        puts ""
        puts "  available converters for password algorithms"
        puts "  ============================================"
        ConverterReader.new.discover.each do |converter|
          puts "  - #{converter}"
        end
        puts "  ============================================"
        puts ""
      end

      # setup working directory
      def setup(value = nil)
        dir = Pathname.new(value || Directories[:user]).expand_path

        dir.mkpath
        (dir + 'algorithms').mkpath
        (dir + 'converters').mkpath

        if File.exist?(dir + 'config')
          puts "configuration in #{dir} not overwritten"
        else
          File.open((dir + 'config'), 'w') do |file|
            config = {}

            ConfigReader.load.each do |key, value|
              config[key.to_s] = ( value.is_a?(Symbol) ? value.to_s : value )
            end

            YAML.dump(config, file)
          end
        end

        puts "successfully created configuration directory in #{dir}"
      end
    end

    protected

    # parse the options
    def parse_options(options = {})
      options = {
        :algorithm => 'basic_de',
        :pipe_out  => false,
        :pipe_in   => false
      }.merge(
        ConfigReader.load
      ).merge(options)

      cli_options = OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename($0)} [options] passphrase"
        opts.separator ""

        opts.on('-a', '--algorithm ALGORITM', "use specified algorithm for transformation") do |value|
          options[:algorithm] = value
        end

        opts.on('-p', '--[no-]pipe', "pipe result to stdout (without trailing linebreak)") do |value|
          options[:pipe_out] = value
        end

        opts.on('-c', '--config [PATH]', "look in PATH for configurations (instead of ~/.to_pass)") do |value|
          dir = Pathname.new(value).expand_path
          if dir.exist?
            options[:path] = dir
          else
            puts 'configuration path not found'
            puts "run '#{File.basename($0)} --setup #{dir}' to set it up"
            exit 1
          end
        end

        ## ACTIONS

        opts.on('--setup [PATH]', "create a configuration directory") do |value|
          Cli.setup(value)
          exit
        end

        opts.on('-A', '--algorithms', "list available algorithms") do |value|
          Cli.algorithms
          exit
        end

        opts.on('-C', '--converters', "list available converters for password algorithms") do |value|
          Cli.converters
          exit
        end

        opts.separator ""

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end
      cli_options.parse!

      if ARGV[0].nil?
        options[:pipe_in] = options[:pipe_out] = true
      end

      options

    rescue OptionParser::InvalidOption
      puts cli_options
      exit 0
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
      Base.new(@string, @options[:algorithm], :path => @options[:path]).to_s
    end
  end
end
