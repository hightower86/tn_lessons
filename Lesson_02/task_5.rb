puts "Введите сегодняшнее число"
day = gets.chomp.to_i
puts "Введите текущий месяц"
month = gets.chomp.to_i
puts "Введите текущий год"
year = gets.chomp.to_i

if year % 4.0 == 0 && year % 100 != 0
  v_year = true
end

months = Hash.new
months[1] = 31
if v_year
  months[2] = 29
else
  months[2] = 28
end
months[3] = 31
months[4] = 30
months[5] = 31
months[6] = 30
months[7] = 31
months[8] = 31
months[9] = 30
months[10] = 31
months[11] = 30
months[12] = 31
day_number = 0
months.each do |m, d|  
  if m < month
    #прибавляем дни месяца
    day_number += d
  elsif m == month
    #прибавляем к посчитанным дни текущего месяца
    day_number += day
  end

end
puts "Сегодня #{day_number}-й день с начала года"