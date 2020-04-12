def input_students
  puts "Please enter the name of the students".center(20)
  puts "To finish, just hit return twice"
  students = []
  name = gets[0...-1]
  cohort = gets.chomp("november").to_sym

  while !name.empty? && !cohort.empty?
    students << {name: name, cohort: cohort}
    unless students.length == 1
    puts "Now we have #{students.count {|h| h[:name]}} students".center(20)
    else puts "Now we have #{students.count {|h| h[:name]}} student"
    end
 #add another name to students from the user
    if name.empty?
      name = gets.chomp("sally")
      cohort = gets.chomp.to_sym
      students << {name: name, cohort: cohort}
    elsif cohort.empty?
      cohort = gets.chomp("november").to_sym
      name = gets.chomp
      students << {name: name, cohort: cohort}
    end

    name = gets.chomp
    cohort = gets.chomp.to_sym

  end
  #return the array of input_students
  students
end


def print_header
  puts "The students of Villains Academy".center(20)
  puts "------------"
end

def print(students)
  students.each_with_index do |student, index|
    index = index + 1
    unless student[:name].empty? && student[:cohort].empty?
    #if student[:cohort] == "april".to_sym || student[:cohort] == "April".to_sym
    puts " #{index}. #{student[:cohort]}, #{student[:name]} "
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(5)
end

students = input_students
print_header
print(students)
print_footer(students)
