require_relative 'error'

class Parser
    def initialize(input)
        @input = input # lexer
        # [Integer] stack of index markers into lookahead buffer
        @markers = []
        # [Token] dynamically-sized lookahead buffer
        @lookahead = []
        # index of current lookahead token
        # LT(1) returns lookahead[p]
        @p = 0
    end

    def consume
        @p += 1
        # have we hit end of bufer when not backtracking
        if @p == @lookahead.length && !isSpeculating()
            @p = 0
            # size goes to 0, but retains memory
            @lookahead.clear
        end

        sync(1)
    end

    # make sure we have i tokens from current position p
    def sync(i)
        if @p+i-1 > @lookahead.length-1 # out of tokens
            n = (@p+i-1) - (@lookahead.length-1)
            fill(n)
        end
    end

    # add n tokens
    def fill(n)
        n.times do
            @lookahead << @input.nextToken
        end
    end

    # --- token access and test methods ---
    def LT(i)
        sync(i)
        return @lookahead[@p+i-1]
    end

    def LA(i)
        return LT(i).type
    end

    def match(x)
        begin
            if LA(1) == x
                consume
            else 
                raise MismatchedTokenError.new("expecting #{@input.getTokenName(x)} found #{LT(1)}")
            end
        end
    end

    # --- marker management ---
    def mark
        @markers.push(@p)
        return @p
    end

    def release
        marker = @markers.pop
        seek(marker)
    end

    def seek(index)
        @p = index
    end

    def isSpeculating 
        return @markers.length > 0
    end
end