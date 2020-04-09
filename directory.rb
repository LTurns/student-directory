@students = [] #so the array is accessible to all methods @does not have to be in a method
#to be accessible

def input_students
  puts "Please enter the name of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
 #add another name to students from the user
    name = STDIN.gets.chomp
  #we change every gets to STDIN.gets so we get the input from the user
  #instead of from an external file - otherwise It reads from the list
  #of files supplied as arguments, only defaulting to the keyboard
  #(or, standard input stream, to be precise) if there are no files
  end
  #return the array of input_students
  @students
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end
#to load the data on the file from start-up, we need to make the
#method work with arbitrary filenames - so make it mire flexible
#by passing the names as the argument. To preserve the original fuctionality,
#we can also give it a default value. (this allows us to connect with either load_students
#or another file - use of default is handy)
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    when "3"
      save_students
    when "4"
      load_students
    else
      puts "I don't know what you mean, try again"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end


interactive_menu












=begin
all of this code from one method can be divided into lots of smaller methods -
refractoring as much as possible is always best.
def interactive_menu
  @students = []
  loop do
  # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
  # 2. read the input and save it into a variable
    selection = gets.chomp
  # 3. do what the user has asked
  case selection
  when "1"
    students = input_students
  when "2"
    print_header
    print(students)
    print_footer(students)
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
  end
end
=end
