defmodule Momento.Guards do
  # Custom guards

  # Is in the set of natural numbers
  defmacro natural?(num), do: quote do: is_integer(unquote(num)) and unquote(num) >= 0

  # Is in set of natural numbers not including 0
  defmacro positive?(num), do: quote do: is_integer(unquote(num)) and unquote(num) > 0

  # Is in the set of natural numbers below 0
  defmacro negative?(num), do: quote do: is_integer(unquote(num)) and unquote(num) < 0

  # Returns how many days are in a given month (natural number)
  defmacro days_in_month(month) do
    month = cond do
      month == 13 -> 1
      month == 0 -> 12
      true -> month
    end

    quote do: elem({31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}, unquote(month) - 1)
  end
end
