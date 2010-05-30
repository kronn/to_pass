# Any Object can be a password :-)
#
# String.send(:include, ToPwd::Integration)
# puts "Da steht ein Pferd auf dem Flur".to_pwd => 'Ds1P@dF'
#
module ToPwd
  module Integration
    def to_pwd( algorithm = 'basic_de' )
      ToPwd::Base.new(self.to_s, algorithm).to_s
    end
  end
end
