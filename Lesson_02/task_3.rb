arr = Array.new()
a = 0
b = 1
c = 1
arr.push(a)
while c <= 100
  arr.push(c)
  c = a + b
  a = b
  b = c
end