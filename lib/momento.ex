defmodule Momento do
  require Momento.Guards

  # date/0
  def date(), do: Momento.Date.date()

  # date/1
  def date(datetime), do: Momento.Date.date(datetime)

  # date!/1
  def date!(datetime), do: Momento.Date.date!(datetime)

  # add/3
  def add(datetime, num, time), do: Momento.Add.add(datetime, num, time)

  # subtract/3
  def subtract(datetime, num, time), do: Momento.Subtract.subtract(datetime, num, time)
end
