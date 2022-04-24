require 'jalalidate' 
require 'date'
require './utils'
###################################################################
 puts "* Task 1"
 print "**************************\n\n Press 1 for Jalali and 2 for Gregorian current date. Otherwise, Ctrl+C\n"
 tabdil = gets.chomp
 if tabdil == '1'
  puts JalaliDate.today.strftime('%a %d %b %Y')
 elsif tabdil ==  '2'
  puts Date.today.strftime('%a %d %b %Y')
 else puts "Not an option!"
 end

 ################################################################## 
 puts "* Task 2"
 print "**************************\n\n choose the calendar format. Press 1 for Jalali and 2 for Gregorian. Otherwise, Ctrl+C\n"
 tabdil = gets.chomp
 print "**************************\n\n Insert the Start date(format: yyyy/m/d). Otherwise, Ctrl+C\n"
 startd = gets
 print "**************************\n\n Insert the end date(format: yyyy/m/d). Otherwise, Ctrl+C\n"
 endd = gets

daily,business = duration(startd,endd,tabdil)
puts daily
puts business
