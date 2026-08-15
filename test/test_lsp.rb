class Person
  def greet
    puts "hello"
  end
end

p = Person.new
p.greet
p.nonexistent_method

p.