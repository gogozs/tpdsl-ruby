require_relative 'Parser.rb'

class ListParser < Parser
    def initialize(input)
        super
    end

    # list     : '[' elements ']' ;        // match bracketed list
    def list
        match(ListLexer::LBRACK)
        elements
        match(ListLexer::RBRACK)
    end

    # elements : element (',' element)* ;  // match comma-separated list
    def elements
        element
        while @lookahead.type == ListLexer::COMMA
            match(ListLexer::COMMA)
            element
        end
    end

    # element  : NAME | list ;             // element is name or nested list
    def element
        if @lookahead.type == ListLexer::NAME
            match(ListLexer::NAME)
        elsif  @lookahead.type == ListLexer::LBRACK
            list
        else
            raise StandardError.new("expecting name or list; found #{@lookahead}")
        end
    end

end