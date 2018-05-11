require_relative 'BacktrackLexer'
require_relative 'BacktrackParser'

lexer = BacktrackLexer.new(ARGV[0])
parser = BacktrackParser.new(lexer)

parser.stat