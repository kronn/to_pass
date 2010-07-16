module ToPass::Converters
  class Downcase
    class << self
      # the string is lowercased
      def downcase(string)
        string.downcase
      end
    end
  end
end
