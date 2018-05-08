require_relative 'LookaheadLexer.rb'

class Parser
    def initialize(input, k)
        @input = input  # Lexer
        @k = k # how many lookahead symbols
        @lookahead = [] # circular lookahead buffer
        @p = 0  # circular index of next token position

        # prime buffer with k lookahead
        @k.times do
            consume
        end
    end

    def consume
        @lookahead[@p] = @input.nextToken
        @p = (@p+1) % @k
    end

    # lookahead token
    # i starting from 1
    def LT(i)
        return @lookahead[(@p + i - 1) % @k]
    end

    # lookahead token type
    def LA(i)
        return LT(i).type
    end

    def match(x)
        begin
            if LA(1) == x
                consume
            else
                raise StandardError.new("expecting #{@input.getTokenName(x)}; found #{LT(1)}")
            end
        end
    end
end