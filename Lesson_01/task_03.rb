puts "Введите длину первой стороны треугольника"
a = gets.chomp.to_f

puts "Введите длину второй стороны треугольника"
b = gets.chomp.to_f

puts "Введите длину третьей стороны треугольника"
c = gets.chomp.to_f

#проверяем является ли тр-к равносторонним
if a == b && a == c && b == c
  ravnostor = true
  puts "Треугольник равнобедренный и равносторонний!"
else 
  storony = [a,b,c] #помещаем стороны в массив
  gip = storony.max #предполагаемая гипотенуза
  storony.delete(gip)  #удаляем из массива "гипотензу" остаются "катеты"
  pr_ugoln = gip**2 == storony[0]**2 + storony[1]**2
  ravnobedr = storony[0] == storony[1]

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
