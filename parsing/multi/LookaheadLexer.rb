require_relative 'Token.rb'
require_relative '../lexer/Lexer.rb'

class LookaheadLexer < Lexer
    NAME = 2
    COMMA = 3
    LBRACK = 4
    RBRACK = 5
    EQUALS = 6

    TokenNames = 
        ["n/a", "<EOF>", "NAME", "COMMA", "LBRACK", "RBRACK", "EQUALS"];

    def getTokenName(x)
        return TokenNames[x]
    end

    def initialize(input)
        super
    end

    def isLETTER
        return @c >= 'a' && @c <= 'z' || @c >= 'A' && @c <= 'Z'
    end

    def nextToken
        while @c != EOF
            case @c
            when ' ', '\t', '\n', '\r'
                WS()
                next
            when ','
                consume
                return Token.new(COMMA, ",")
            when '['
                consume
                return Token.new(LBRACK, "[")
            when ']'
                consume
                return Token.new(RBRACK, "]")
            when '='
                consume
                return Token.new(EQUALS, "=")
            else
                begin
                    if isLETTER()
                        return NAME()
                    else
                        raise StandardError.new("invalid character: #{@c}")
                    end
                end
            end
        end

        return Token.new(EOF_TYPE, "<EOF>")
    end

    def NAME
        buf = ""
        loop do
            buf += @c
            consume()
            break if not isLETTER()
        end

        return Token.new(NAME, buf)
    end

    def WS
        while @c == ' ' || @c == '\t' || @c == '\n' || @c == '\r'
            consume()
        end
    end
end
