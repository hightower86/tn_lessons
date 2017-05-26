#программа для подсчета купленного товара

fin_sum = 0

loop do
  puts "Введите название товара"
  title = gets.chomp

  break if title == "стоп"
  puts "Введите количество товара"
  number = gets.chomp.to_f
  puts "Введите Цену товара"
  price = gets.chomp.to_f
  sum = number * price
  h = { title => { number => price } }
  puts "#{h} на сумму #{ sum }"
  fin_sum += sum
  # здесь идет обработка ввода, в зависимости от выбранного варианта
end

puts "В корзине товары на сумму #{fin_sum}"