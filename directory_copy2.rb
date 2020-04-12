@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to the filename of your choice"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
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
      @user_file = STDIN.gets.chomp
      save_students
    when "4"
      load_students
    else
      puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "Please enter the name of the students"
  puts "To finish, just hit return twice"
  @name = STDIN.gets.chomp
  while !@name.empty?
    puts "Thank you for adding a name"
    students_count
    @name = STDIN.gets.chomp
  end
end

def students_count
    @students << {name: @name, cohort: "november".to_sym}
    puts "Now we have #{@students.count} students"
  #return the array of input_students
  @students
end

#how to close with a block so you don't need to use file.close
#File.open('Leo Tolstoy - War and Peace.txt', 'w') do |f|
#f << "Well, Prince, so Genoa and Lucca"
#  f << " are now just family estates of the Buonapartes."
#end

def save_students
  file = CSV.open(@user_file, "w") do |csv|
    @students.each do |student|
     student_data = [student[:name], student[:cohort]]
     csv_line = student_data.join(",")
     csv << csv_line
   end
  end
end

#could potentially put @infront of filename so we can stick with the same variable
#the different load and save methods - this would make things smaller.

def load_students(filename = @user_file)
  file = CSV.open(filename, "r")
  file.foreach do |row|
    puts row
  end
    input_students
end

#to load the data on the file from start-up, we need to make the
#method work with arbitrary filenames - so make it mire flexible
#by passing the names as the argument. To preserve the original fuctionality,
#we can also give it a default value. (this allows us to connect with either load_students
#or another file - use of default is handy)

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

def show_students
  print_header
  print_students_list
  print_footer
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
