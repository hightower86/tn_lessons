puts "Введите сегодняшнее число"
day = gets.chomp.to_i
puts "Введите текущий месяц"
month = gets.chomp.to_i
puts "Введите текущий год"
year = gets.chomp.to_i

if year % 400.0 == 0
  v_year = true
elsif year % 4.0 == 0 && year % 100.0 != 0 
  v_year = true
end

months = []
months << 31  #январь
if v_year
  months << 29
else
  months << 28
end
months << 31
months << 30
months << 31
months << 30
months << 31
months << 31
months << 30
months << 31
months << 30
months << 31
day_number = 0
months.each.with_index(1) do |d, i|  
  if i  < month
    #прибавляем дни месяца
    day_number += d
  elsif i  == month
    #прибавляем к посчитанным дни текущего месяца
    day_number += day
  end

end
puts "Сегодня #{day_number}-й день с начала года"