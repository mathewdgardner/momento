defmodule Momento.Guards do
  # Custom guards
  defmacro positive?(num), do: quote do: is_integer(unquote(num)) and unquote(num) > 0
  defmacro negative?(num), do: quote do: is_integer(unquote(num)) and unquote(num) < 0
  defmacro days_in_month(month), do: quote do: elem({31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}, unquote(month) - 1)
end
