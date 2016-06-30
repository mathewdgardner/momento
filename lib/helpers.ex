defmodule Momento.Helpers do
  def floor(float), do: Float.floor(float) |> round
  def millisecond_factor(precision), do: :math.pow(10, precision - 3) |> round
  def microsecond_factor(precision), do: :math.pow(10, precision) |> round
end
