require_relative 'LookaheadParser'
require_relative 'LookaheadLexer'

lexer = LookaheadLexer.new(ARGV[0])
parser = LookaheadParser.new(lexer, 2) # lookahead 2 symbols

parser.list