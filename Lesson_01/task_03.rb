puts "Введите длину первой стороны треугольника"
a = gets.chomp.to_i

puts "Введите длину второй стороны треугольника"
b = gets.chomp.to_i

puts "Введите длину третьей стороны треугольника"
c = gets.chomp.to_i

#вычисляем самую длинную сторону и назовем ее "пока" гипотенузой
gip = [a,b,c].max()

#проверяем является ли тр-к равносторонним
if a == b && a == c && b == c
	ravnostor = true
	puts "Треугольник равнобедренный и равносторонний!"
else 

   if gip == a  #сторона а является самой длинной
	  # проверим теорему Пифагора
	  pr_ugoln = (a**2 == b**2 + c**2)
	  ravnobedr = (b == c)
   elsif 
 	  gip == b
      pr_ugoln = (b**2 == a**2 + c**2)
      ravnobedr = (a == c)
   elsif 
 	  gip == c
      pr_ugoln = (c**2 == a**2 + b**2)
      ravnobedr = (a == b)
   end

   if pr_ugoln 
   	puts "Треугольник прямоугольный!"
   	if ravnobedr
   		puts " и равнобедренный!"
   	end
   else 
   	puts "Треугольник НЕ является прямоугольным!"
     if ravnobedr
   		puts " но является равнобедренным!"
    	end
   	
   end
end
