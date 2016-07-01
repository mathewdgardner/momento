defmodule Momento.Helpers do
  @spec floor(float) :: integer
  def floor(float), do: Float.floor(float) |> round

  @spec millisecond_factor(integer) :: integer
  def millisecond_factor(precision), do: :math.pow(10, precision - 3) |> round

  @spec microsecond_factor(integer) :: integer
  def microsecond_factor(precision), do: :math.pow(10, precision) |> round
end
