defmodule Users do
  dave = %{ name: "Dave", age: 27 }

  case dave do
    %{age: age} = person  when is_number(age) and age >= 21 ->
      IO.puts "You are #{age}, You are cleared to enter the Foo Bar, #{person.name}" 
    _ ->
      IO.puts "No admission"
  end
end
