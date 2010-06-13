module ToPwd
  # The StringConversions-Module is a collection of available
  # Transformations. Every method is given a string as single argument
  # and is expected to return a transformed string. The only exception
  # from this is general rule is the replace method which also takes a
  # replacement table.
  #
  # This enables chaining and eases extending the capabilities.
  module StringConversions
    # all the blanks are removed.
    #
    # this is useful if you convert a sentence into a password.
    def collapse_chars(string)
      string = string.split(' ').join('')
    end

    # reduces every word to its first character, preserving case
    def first_chars(string)
      string.split(' ').map do |word|
        word[0].chr
      end.join(' ')
    end

    # alternate case of letter (not numbers)
    def swapcase(string)
      pwd = ""
      last_upcase = true

      string.each_char do |char|
        char = if char.between?("0", "9")
                 char
               elsif last_upcase
                 last_upcase = false
                 char.downcase
               else
                 last_upcase = true
                 char.upcase
               end
        pwd << char
      end
      pwd
    end

    # perform replacements on a string, based on a replacment table
    def replace(string, table)
      table.inject(string) do |pwd, map|
        pwd = pwd.gsub(/#{map[0].to_s}/, map[1].to_s)
      end
    end
  end
end
