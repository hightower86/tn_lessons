arr = []
a = 0
b = 1
c = 1
arr << a
while c <= 100
  arr << c
  c = a + b
  a, b = b, c
end
puts arr

# ar = []
# ar << 0
# ar << 1
# i = 1
# while ar[ i ] <= 100
#   ar[ i ] = ar[ i-1 ] + ar[ i-2 ] 
#   i += 1
# end
# puts ar   с этим способом не разобрался.