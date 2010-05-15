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
      if string.include? ' '
        from_sentence(string)
      else
        from_word(string)
      end
    end

    protected

    def from_word(string)
      @rules['from_word'].inject(string) do |pwd, rule|
        pwd = if rule.is_a?(String) and respond_to?(rule.to_sym)
                send(rule.to_sym, pwd)
              elsif rule.is_a?(Hash) and rule.has_key?('table')
                replace(pwd, @rules['tables'][rule.fetch('table')])
              else
                pwd
              end
      end
    end

    def from_sentence(string)
      string
    end

    # def separate_chars(string)
    #   string = string.split('').join(' ')
    # end

    # def collapse_chars(string)
    #   string = string.split(' ').join('')
    # end

    def swapcase(string)
      pwd = ""
      last_upcase = true
      string.each_char do |char|
        pwd << if char.between?("0", "9")
                 char
               elsif last_upcase
                 last_upcase = false
                 char.downcase
               else
                 last_upcase = true
                 char.upcase
               end
      end
      pwd
    end

    def replace(string, table)
      table.inject(string) do |pwd, map|
        pwd = pwd.gsub(/#{map[0].to_s}/, map[1].to_s)
      end
    end

#   def first_chars
#     array = @password.split(' ').map do |word|
#       word[0].chr
#     end
# 
#     array.join(' ')
#   end
  end
end
