require_relative '../lexer/Lexer.rb'
require_relative '../lexer/Token.rb'

class Parser

    def initialize(input)
        @input = input;
        consume
    end

    def match(x)
        begin
            if @lookahead.type == x
                consume
            else
                raise ArgumentError.new("expecting #{@input.getTokenName(x)}; found #{@lookahead}")
            end
        end
    end

    def consume
        @lookahead = @input.nextToken
    end
end
