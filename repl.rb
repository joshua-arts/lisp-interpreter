require_relative 'lisp.rb'

puts "Ruby Lisp REPL"
puts "Exit the REPL by typing 'quit'."
$interpreter = Lisp.new

def handle_input(input)
  result = $interpreter.interpret(input)
  puts(" => #{result}")
end

def repl(prompt)
    print prompt
    input = gets.chomp!
    exit if input == 'quit'
    handle_input(input)
end

while true do
    repl(">> ")
end
