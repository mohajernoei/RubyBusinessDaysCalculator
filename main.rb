require './utils'

###################################################################
 puts "\n\n\n*** Task 1"
 print "**************************\n\n Press 1 for Jalali and 2 for Gregorian current date. Otherwise, Ctrl+C\n"
 type = gets.chomp
 if type == '1'
  puts JalaliDate.today.strftime('%a %d %b %Y')
 elsif type ==  '2'
  puts Date.today.strftime('%a %d %b %Y')
 else puts "Not an option!"
 end

 ################################################################## 
 puts "\n\n\n*** Task 2"
 print "**************************\n\n choose the calendar format. Press 1 for Jalali and 2 for Gregorian. Otherwise, Ctrl+C\n"
 type = gets.chomp
 print "**************************\n\n Insert the Start date(format: yyyy/m/d). Otherwise, Ctrl+C\n"
 prior_date = gets
 print "**************************\n\n Insert the end date(format: yyyy/m/d). Otherwise, Ctrl+C\n"
 later_date = gets
 
first_date =  JGtime.new(prior_date,type)
second_date = JGtime.new(later_date,type)
puts (second_date - first_date)
puts (second_date / first_date)

