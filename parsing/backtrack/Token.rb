require_relative 'BacktrackLexer'

class Token
    attr_accessor :type

	def initialize(type, text)
		@type = type
		@text = text
	end	

	def to_s
        tname = BacktrackLexer::TokenNames[@type]
        return "<'#{@text}', #{tname}>"
	end
end
