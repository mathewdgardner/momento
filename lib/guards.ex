defmodule Momento.Guards do
  @doc """
  Is in the set of natural numbers?

  ## Examples

      iex> Momento.Guards.natural?(5)
      true

      ...> Momento.Guards.natural?(0)
      true

      ...> Momento.Guards.natural?(-5)
      false
  """
  @spec natural?(integer) :: boolean
  defmacro natural?(num), do: quote do: unquote(num) |> is_integer and unquote(num) >= 0

  @doc """
  Is in set of natural numbers not including 0?

  ## Examples

      iex> Momento.Guards.positive?(5)
      true

      ...> Momento.Guards.positive?(0)
      false

      ...> Momento.Guards.positive?(-5)
      false
  """
  @spec positive?(integer) :: boolean
  defmacro positive?(num), do: quote do: unquote(num) |> is_integer and unquote(num) > 0

  @doc """
  Is in the set of natural numbers below 0?

  ## Examples

      iex> Momento.Guards.negative?(-5)
      true

      ...> Momento.Guards.negative?(0)
      false

      ...> Momento.Guards.negative?(5)
      false
  """
  @spec negative?(integer) :: boolean
  defmacro negative?(num), do: quote do: unquote(num) |> is_integer and unquote(num) < 0

  @doc """
  Provides thow many days are in a given month (natural number) and is rollover safe.

  ## Examples

      iex> Momento.Guards.days_in_month(2)
      28

      ...> Momento.Guards.days_in_month(14)
      28
  """
  @spec days_in_month(integer) :: integer
  defmacro days_in_month(month) do
    month = cond do
      month > 12 -> quote do: unquote(month) |> rem(12)
      month == 0 -> 12

      # TODO: Make a negative number index from the end
      # TODO: abs/1 doesn't seem to be working here
      month < 0  -> quote do: unquote(month) |> abs |> rem(12)
      true       -> month
    end

    quote do: elem({31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}, unquote(month) - 1)
  end
end
