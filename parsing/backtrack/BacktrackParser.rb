require_relative 'Parser'
require_relative 'BacktrackLexer'

class BacktrackParser < Parser

    # stat     : list EOF | assign EOF ;
    def stat
        begin
            # list EOF
            if speculate_state_alt1
                list
                match(BacktrackLexer::EOF_TYPE)
            # assign EOF
            elsif speculate_state_alt2
                assign
                match(BacktrackLexer::EOF_TYPE)
            else
                # must be an error; neither matched; LT(1) is lookahead token 1
                raise NoViableAltError.new("expecting stat found #{LT(1)}")
            end
        end
    end

    def speculate_state_alt1
        success = true

        mark # mark this spot in input so we can rewind
        begin
            list
            match(BacktrackLexer::EOF_TYPE)
        rescue RecognitionError => e
            success = false
        end
        release # either way, rewind to we were

        return success
    end

    def speculate_state_alt2
        success = true

        mark
        begin
            assign
            match(BacktrackLexer::EOF_TYPE)
        rescue RecognitionError => e
            success = false
        end
        release

        return success
    end


    # assign   : list '=' list ;
    def assign
        list
        match(BacktrackLexer::EQUALS)
        list
    end

    # list     : '[' elements ']' ;        // match bracketed list
    def list
        match(BacktrackLexer::LBRACK)
        elements
        match(BacktrackLexer::RBRACK)
    end

    # elements : element (',' element)* ;  // match comma-separated list
    def elements
        element
        while LA(1) == BacktrackLexer::COMMA
            match(BacktrackLexer::COMMA)
            element
        end
    end

    # element  : NAME '=' NAME | NAME | list ;
    def element
        begin
            if LA(1) == BacktrackLexer::NAME && LA(2) == BacktrackLexer::EQUALS
                match(BacktrackLexer::NAME)
                match(BacktrackLexer::EQUALS)
                match(BacktrackLexer::NAME)
            elsif LA(1) == BacktrackLexer::NAME
                match(BacktrackLexer::NAME)
            elsif LA(1) == BacktrackLexer::LBRACK
                list
            else
                raise NoViableAltError.new("expecting element found #{LT(1)}")
            end
        end
    end

end