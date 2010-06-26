module ToPass::StringConversions
  class Replace
    # perform replacements on a string, based on a replacment table
    def replace(string, table)
      table.inject(string) do |pwd, map|
        pwd = pwd.gsub(/#{map[0].to_s}/, map[1].to_s)
      end
    end
  end
end
