module ToPwd
  # converts a given string into a password-like word
  #
  # the string can be a word or a sentence. everthing which
  # contains whitespace is considered a sentence
  class Converter
    def initialize( rules )
      @rules = rules
    end

    def convert( string )
      process(string, rules_for(string))
    end

    protected

    include StringConversions

    private

    def rules_for( string )
      if string.include? ' '
        @rules['from_sentence']
      else
        @rules['from_word']
      end
    end

    def process(string, rules)
      rules.inject(string) do |pwd, rule|
        if rule.is_a?(String) and respond_to?(rule.to_sym)
          send(rule.to_sym, pwd)
        elsif rule.is_a?(Hash) and rule.has_key?('table')
          replace(pwd, @rules['tables'][rule.fetch('table')])
        else
          pwd
        end
      end
    end
  end
end
