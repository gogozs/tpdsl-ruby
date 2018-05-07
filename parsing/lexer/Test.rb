require_relative 'ListLexer.rb'

lexer = ListLexer.new(ARGV[0])

t = lexer.nextToken

while t.type != Lexer::EOF_TYPE
    puts t.to_s
    t = lexer.nextToken
end
