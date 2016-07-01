defmodule Momento.Helpers do
  @doc """
  Helper to get the floor of a `float` in the form of an `integer`.

  ## Examples

      iex> use Momento
      ...> Momento.Helpers.floor(5.22)
      5
  """
  @spec floor(float) :: integer
  def floor(float), do: Float.floor(float) |> round

  @doc """
  Helper to get the factor needed to get milliseconds from a given precision.

  ## Examples

      iex> use Momento
      ...> Momento.Helpers.millisecond_factor(6)
      1000
  """
  @spec millisecond_factor(integer) :: integer
  def millisecond_factor(precision), do: :math.pow(10, precision - 3) |> round

  @doc """
  Helper to get the factor needed to get microseconds from a given precision.

  ## Examples

      iex> use Momento
      ...> Momento.Helpers.microsecond_factor(6)
      1000000
  """
  @spec microsecond_factor(integer) :: integer
  def microsecond_factor(precision), do: :math.pow(10, precision) |> round
end
