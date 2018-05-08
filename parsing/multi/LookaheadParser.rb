require_relative 'Parser.rb'
require_relative 'LookaheadLexer.rb'

class LookaheadParser < Parser

    # list     : '[' elements ']' ;        // match bracketed list
    def list
        match(LookaheadLexer::LBRACK)
        elements
        match(LookaheadLexer::RBRACK)
    end

    # elements : element (',' element)* ;  // match comma-separated list
    def elements
        element
        while LA(1) == LookaheadLexer::COMMA
            match(LookaheadLexer::COMMA)
            element
        end
    end

    # element  : NAME '=' NAME | NAME | list ;
    def element
        begin
            if LA(1) == LookaheadLexer::NAME && LA(2) == LookaheadLexer::EQUALS
                match(LookaheadLexer::NAME)
                match(LookaheadLexer::EQUALS)
                match(LookaheadLexer::NAME)
            elsif LA(1) == LookaheadLexer::NAME
                match(LookaheadLexer::NAME)
            elsif LA(1) == LookaheadLexer::LBRACK
                list
            else
                raise StandardError.new("expecting name or list; found #{LT(1)}")
            end
        end
    end
end