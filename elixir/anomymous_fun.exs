my_fun = fn
  :plus, a, b -> a+b
  :times, a, b -> a*b
end

IO.puts my_fun.(:plus, 4,5)
IO.puts my_fun.(:times, 4,5)
