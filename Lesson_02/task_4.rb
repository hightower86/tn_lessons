arrlet = ["a", "e", "i", "j", "o", "u", "y"]
#count = 0
l_hash = {} 
('a'..'z').each.with_index(1) do |letter, i|
  #count += 1
  if arrlet.include?(letter) 
    l_hash[letter] = i
  end
end
puts l_hash