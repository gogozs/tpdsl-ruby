require_relative 'LookaheadParser.rb'
require_relative 'LookaheadLexer.rb'

lexer = LookaheadLexer.new(ARGV[0])
parser = LookaheadParser.new(lexer, 2) # lookahead 2 symbols

parser.list