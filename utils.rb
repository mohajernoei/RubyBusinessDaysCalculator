require 'date'
require 'jalalidate'

#These are predefined holidays manually entered as an array!
$holidays = [[3, 21], [3, 22], [3, 23], [3, 24], [4, 1], [4, 2], [6, 4], [6, 5], [2, 11], [3, 20]]


def jalaliwd(x)
  case x[0,3]
  when 'Sat'
    return "ش"
  when 'Sun'
    return "ی"
  when "Mon"
    return "د"
  when "Tue"
    return "س"
  when "Wed"
    return "چ"
  when "Thu"
    return "پ"
  when "Fri"
    return "ج"
  end
end
  
def jalali_month(x)
  case x
  when 1
    return 'Farvardin '
  when 2
    return 'Ordibehesht '
  when 3
    return 'Khordad '
  when 4
    return 'Tir '
  when 5
    return 'Mordad '
  when 6
    return 'Shahrivar '
  when 7
    return 'Mehr '
  when 8
    return 'Aban '
  when 9
    return 'Azar '
  when 10
    return 'Dey '
  when 11
    return 'Bahman '
  when 12
    return 'Esfand '
  end
end

def is_off(d)
  if d.strftime('%a %d %b %Y')[0,3] =='Thu' or d.strftime('%a %d %b %Y')[0,3] == 'Fri'
    return true
  end
  return false
end

def is_holy(d)
 if $holidays.include?([d.month,d.day]) 
  return true 
end
 return false
end

def swap_if_needed(a,b)
  if b.startg < a.startg 
  return b,a
  end
return a,b
end






class JGtime < JalaliDate
  attr_accessor :startg
  def initialize(startd,tabdil)
    s1,s2,s3 = startd.split('/')
    if tabdil == '1'
    s1,s2,s3 = super(s1.to_i,s2.to_i,s3.to_i)
    @startg = Date.new(s1,s2,s3)
    else   
    @startg = Date.new(s1.to_i,s2.to_i,s3.to_i)
    end
    
  end
  
  
  def -(obj)
    @daily = (self.startg - obj.startg).to_i  
    return @daily
    end
  
  def /(obj)
    @business = (self.startg - obj.startg).to_i  
    while (self.startg-obj.startg)%7 != 0
    if(is_off(obj.startg) or is_holy(obj.startg))
    @business -= 1
    end
    obj.startg += 1
  end
    for i in obj.startg.year..self.startg.year
      for j in $holidays
      if obj.startg < Date.new(i,j[0],j[1]) and self.startg > Date.new(i,j[0],j[1]) and  !is_off(Date.new(i,j[0],j[1]))
        @business -= 1
      end
     end
    end
    @business -= @business*2/7
    return @daily,@business
    
  
  end
  end
  