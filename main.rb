require_relative 'lisp.rb'

interpreter = Lisp.new

File.open('sample.lisp').each{ |line|
    result = interpreter.interpret(line)
    puts(" => #{result}")
}
