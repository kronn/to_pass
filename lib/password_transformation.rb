class PasswordString
	attr_reader :password

	def initialize( string )
		@password = string

		if @password.include? ' '
			@password = from_sentence
		else
			@password = from_word
		end
	end

	def to_s
		@password
	end

	def inspect
		to_s
	end

	protected
	
	def from_sentence
		@password = convert_numbers
		@password = first_chars
		@password = convert_symbols
		@password = one_word
	end

	def from_word
		@password = separate_chars
		@password = convert_chars
		@password = convert_symbols
		@password = one_word
	end

	# unterscheidung nach sprachen?
	WORD_TO_NUMBER = {
		:ein => 1,
		:eine => 1,
		:zwei => 2,
		:drei => 3,
		:vier => 4,
		:fuenf => 5,
		:sechs => 6,
		:sieben => 7,
		:acht => 8,
		:neun => 9
	}
	CHAR_TO_SYMBOL = {
		:a => '@'
	}
	CHAR_TO_NUMBER = {
		:a => 4,
		:e => 3,
		:i => 1,
		:o => 0,
		:s => 5
	}

	def convert_numbers
		convert(WORD_TO_NUMBER)
	end
	def convert_chars
		convert(CHAR_TO_NUMBER)
	end
	def convert_symbols
		convert(CHAR_TO_SYMBOL)
	end

	def first_chars
		array = @password.split(' ').map do |word|
			word[0].chr
		end

		array.join(' ')
	end

	def separate_chars
		@password.split('').join(' ')
	end

	def one_word
		@password.split(' ').join('')
	end

	private

	def convert(table)
		array = @password.split(' ').map do |part|
			psym = part.downcase.to_sym

			if table.include? psym
				table[psym]
			else
				part
			end
		end

		array.join(' ')
	end
end

# module PasswordTransformation
# 	def to_pwd( klass = PasswordString )
# 		klass.new(self.to_s)
# 	end
# end
# 
# class String
# 	include PasswordTransformation
# end
# 
# puts "Da steht ein Pferd auf dem Flur".to_pwd
