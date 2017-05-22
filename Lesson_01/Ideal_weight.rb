

puts "Как Вас зовут ?"
u_name = gets.chomp

puts "Какой Ваш рост (в сантиметрах) ?"
height = gets.chomp.to_i
ideal_weight = height - 110

if ideal_weight < 0 
  puts "#{u_name}, Ваш вес уже оптимальный!"
else
  puts "#{u_name}, Ваш идеальный вес #{ideal_weight} кг."
end