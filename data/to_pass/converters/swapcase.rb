module ToPass::Converters
  class Swapcase
    class << self
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
    end
  end
end
