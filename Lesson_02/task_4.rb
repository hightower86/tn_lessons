arrlet = ["a", "e", "i", "j", "o", "u", "y"]
count = 0
l_hash = Hash.new 
('a'..'z').each do |letter|
  count += 1
  if arrlet.include?(letter) 
    l_hash[letter] = count
  end
end
puts l_hash