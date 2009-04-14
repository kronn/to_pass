module PasswordTransformation
	def to_pwd
		string = self.dup
		string.convert_numbers.first_chars.leetify.one_word
	end

	protected

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
	# unterscheidung nach sprachen?
	def convert_numbers
		convert(WORD_TO_NUMBER)
	end

	def first_chars
		array = self.split(' ').map do |word|
			word[0].chr
		end

		array.join(' ')
	end

	def one_word
		self.split(' ').join()
	end

	LEETIFY_DEFINITIONS = {
		:a => '@'
	}
	def leetify
		convert(LEETIFY_DEFINITIONS)
	end

	private

	def convert(table)
		array = self.split(' ').map do |part|
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

class String
	include PasswordTransformation
end

puts "Da steht ein Pferd auf dem Flur".to_pwd
