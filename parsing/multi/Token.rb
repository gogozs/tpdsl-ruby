require_relative 'LookaheadLexer.rb'

class Token
    attr_accessor :type

	def initialize(type, text)
		@type = type
		@text = text
	end	

	def to_s
        tname = LookaheadLexer::TokenNames[@type]
        return "<'#{@text}', #{tname}>"
	end
end
