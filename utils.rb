require 'date'
require 'jalalidate'

=begin
These are predefined holidays manually entered as an array!
Which represent the holidays in Gregorian.
=end
$holidays = [[3, 21], [3, 22], [3, 23], [3, 24], [4, 1], [4, 2], [6, 4], [6, 5], [2, 11], [3, 20]]

def is_off(dt)
  if dt.strftime('%a %d %b %Y')[0,3] =='Thu' or dt.strftime('%a %d %b %Y')[0,3] == 'Fri'
    return true
  end
  return false
end

def is_holy(dt)
 if $holidays.include?([dt.month,dt.day]) 
  return true 
end
 return false
end



class JGtime < JalaliDate
  attr_accessor :selected_date
  def initialize(slctd_dt,calendar_type)
    year,month,day = slctd_dt.split('/')
    if calendar_type == '1'
    year,month,day = super(year.to_i,month.to_i,day.to_i)
    @selected_date = Date.new(year,month,day)
    else   
    @selected_date = Date.new(year.to_i,month.to_i,day.to_i)
    end
    
  end

  def -(prior_date_obj)
    @daily_difference = (self.selected_date - prior_date_obj.selected_date).to_i  
    return @daily_difference
    end
  
  def /(prior_date_obj)
    @business_days = (self.selected_date - prior_date_obj.selected_date).to_i  
    while (self.selected_date-prior_date_obj.selected_date)%7 != 0
    if(is_off(prior_date_obj.selected_date) or is_holy(prior_date_obj.selected_date))
    @business_days -= 1
    end
    prior_date_obj.selected_date += 1
  end
    for yr in prior_date_obj.selected_date.year..self.selected_date.year
      for j in $holidays
      if prior_date_obj.selected_date < Date.new(yr,j[0],j[1]) and self.selected_date > Date.new(yr,j[0],j[1]) and  !is_off(Date.new(yr,j[0],j[1]))
        @business_days -= 1
      end
     end
    end
    @business_days -= @business_days*2/7
    return @daily_difference,@business_days
    
  
  end
  end
  