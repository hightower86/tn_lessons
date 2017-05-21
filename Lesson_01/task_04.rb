puts "Введите 1-й коэффициент"
a = gets.chomp.to_i

puts "Введите 2-й коэффициент"
b = gets.chomp.to_i

puts "Введите 3-й коэффициент"
c = gets.chomp.to_i

d = b ** 2 - 4 * a * c
if d < 0
	puts "Дискриминант = #{d} Корней нет!"
elsif d == 0
	x = -b / (2.0 * a)
	puts "Дискриминант = #{d} Корень один и равен #{x}!"
else
	sqrt_D = Math.sqrt(d) #квадратный корень Дискриминанта
	x_1 = (sqrt_D - b) / (2.0 * a)
	x_2 = (-b - sqrt_D) / (2.0 * a)
	puts "Дискриминант = #{d}"
    puts "Первый корень #{x_1}"
    puts "Второй корень #{x_2}"

end