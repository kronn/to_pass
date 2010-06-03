# Any Object can be a password, as long as it has a string representation.
#
# This Module provides a shortcut to the password-conversion.
#
#   String.send(:include, ToPwd::Integration)
#   puts "Da steht ein Pferd auf dem Flur".to_pwd => 'Ds1P@dF'
#
module ToPwd::Integration
  # simplified password-creation
  def to_pwd( algorithm = 'basic_de' )
    ToPwd::Base.new(self.to_s, algorithm).to_s
  end
end
