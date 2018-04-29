class Lexer

    EOF = -1 # represent end of file char
	EOF_TYPE = 1 # represent EOF token type

	def initialize(input)
		@input = input # input string
		@p = 0 # index into input of current character
		@c = input[@p] # prime lookahead
	end

    # Move one character; detect "end of file"
    def consume
        @p += 1
        if @p >= @input.length
            @c = EOF
        else
            @c = @input[@p]
        end
    end

    # Ensure x is next character on the input stream
    def match(x)
        begin
            if @c == x
                consume
            else
                raise ArgumentError.new("expecting +#{x}+; found+#{c}")
            end
        end
    end

    def nextToken
    end

    def getTokenName(tokenType)
    end
end
