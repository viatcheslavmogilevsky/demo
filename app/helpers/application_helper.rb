module ApplicationHelper

 def title
   base_title = "Ruby on Rails Test App"
   if @title.nil?
     base_title
   else
     "#{base_title} | #{@title}"
   end
 end

 def scatter(args,_controller)
   current_year,current_month,current_day = nil,nil,nil
   event_count = 1
   global_res = ''
   args.each do |arg|
     if current_year != arg.year
       global_res << finish_month(current_year,current_month,current_day,event_count,_controller)
       global_res << finish_year(current_year)
       global_res << start_year(arg)
       global_res << start_month(arg)
       current_year,current_month,current_day = arg.year, arg.month, arg.day
       event_count = 1
     elsif current_month != arg.month
       global_res << finish_month(current_year,current_month,current_day,event_count,_controller)
       global_res << start_month(arg)
       current_month,current_day = arg.month, arg.day
       event_count = 1
     elsif current_day != arg.day
       global_res << finish_month_to(arg.day, current_year, current_month, current_day, event_count,_controller)
       current_day = arg.day
       event_count = 1
     else
       event_count += 1
     end
   end
   global_res << finish_month(current_year,current_month,current_day,event_count,_controller)
   global_res << finish_year(current_year)
 end

 private

 def finish_month_to(day, year, month,start_day,count,_controller)
   date = Date.new(year,month,start_day)
   res = show_current_day(date,count,_controller)
   date= date.next_day
   while date.day != day
    res << %(<tr>) if date.monday?
    res << %(<td class ="someday">#{date.day}</td>)
    res << %(</tr>) if date.sunday?
    date = date.next_day
   end
   res
 end

 def show_prev_month(date)
   date = date.prev_month.end_of_month
   return "" if date.sunday?
   day = date.monday.day
   res = %(<tr>)
   date.cwday.times do |i|
     res << %(<td class="otherday">#{day+i}</td>)
   end
   res
 end

 def show_current_month_to(date)
   res = ''
   day = date.day
   date = date.beginning_of_month
   until day == date.day
     res << %(<tr>) if date.monday?
     res << %(<td class="someday">#{date.day}</td>)
     res << %(</tr>) if date.sunday?
     date = date.next_day
   end
   res
 end

 def start_month(date)
   res = %(<table class="month"> <colgroup span="7"> </colgroup>)
   res << %(<tr><td>#{Date::MONTHNAMES[date.month]}</td></tr>)
   res << show_prev_month(date)
   res << show_current_month_to(date)
 end

 def finish_year(year)
   return "" unless year
   %(</div>)
 end

 def finish_month(year, month, day, count,_controller)
   return "" unless year
   date = Date.new(year,month,day)
   res = show_current_day(date,count,_controller)
   res << show_current_month(date)
   res << show_next_month(date)
   res << %(</table>)
 end

 def show_current_day(day,count,_controller)
   res = ''
   res << %(<tr>) if day.monday?
   res <<  %(<td class ="iday">)
   res << link_to(%[#{day.day} (#{count})],:controller =>_controller, :action => :events_for, :year => day.year, :month => day.month, :day => day.day )
   res << %(</td>)
   res << %(</tr>) if day.sunday?
   res
 end

 def show_current_month(date)
   res = ''
   month = date.month
   date = date.next_day
   while month == date.month
     res << %(<tr>) if date.monday?
     res << %(<td class="someday">#{date.day}</td>)
     res << %(</td>) if date.sunday?
     date = date.next_day
   end
   res
 end

 def show_next_month(date)
   date = date.next_month.beginning_of_month
   return "" if date.monday?
   res = ''
   (8-date.cwday).times do |i|
     res << %(<td class ="otherday">#{i+1}</td>)
   end
   res << %(</tr>)
 end

 def start_year(date)
   %(<div class ="year"><h1> #{date.year} </h1>)
 end
end
