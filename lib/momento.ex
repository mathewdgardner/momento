defmodule Momento do
  require Momento.Guards

  @spec date() :: DateTime.t
  def date(), do: Momento.Date.date()

  @spec date(DateTime.t) :: DateTime.t
  def date(datetime), do: Momento.Date.date(datetime)

  @spec date!(DateTime.t) :: DateTime.t
  def date!(datetime), do: Momento.Date.date!(datetime)

  @spec add(DateTime.t, integer, atom) :: DateTime.t
  def add(datetime, num, time), do: Momento.Add.add(datetime, num, time)

  @spec subtract(DateTime.t, integer, atom) :: DateTime.t
  def subtract(datetime, num, time), do: Momento.Subtract.subtract(datetime, num, time)

  @spec format(DateTime.t, String.t) :: DateTime.t
  def format(datetime, tokens), do: Momento.Format.format(datetime, tokens)
end
