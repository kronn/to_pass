module ToPwd
  module StringConversions
    def collapse_chars(string)
      string = string.split(' ').join('')
    end
    def first_chars(string)
      string.split(' ').map do |word|
        word[0].chr
      end.join(' ')
    end

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

    def replace(string, table)
      table.inject(string) do |pwd, map|
        pwd = pwd.gsub(/#{map[0].to_s}/, map[1].to_s)
      end
    end
  end
end
