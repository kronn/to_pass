module ToPass::Converters
  class Replace
    class << self
      # perform replacements on a string, based on a replacment table
      def replace(string, rules, tablename)
        rules['replacements'][tablename].inject(string) do |pwd, map|
          pwd = pwd.gsub(/#{map[0].to_s}/, map[1].to_s)
        end
      end
    end
  end
end
