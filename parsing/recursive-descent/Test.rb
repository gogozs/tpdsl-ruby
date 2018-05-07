require_relative 'ListParser.rb'
require_relative '../lexer/ListLexer.rb'

lexer = ListLexer.new(ARGV[0])

parser = ListParser.new(lexer)

parser.list