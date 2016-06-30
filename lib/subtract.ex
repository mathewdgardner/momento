defmodule Momento.Subtract do
  import Momento.Guards
  import Momento.Helpers

  # Singular to plural
  def subtract(datetime, num, :year), do: subtract(datetime, num, :years)
  def subtract(datetime, num, :month), do: subtract(datetime, num, :months)
  def subtract(datetime, num, :day), do: subtract(datetime, num, :days)
  def subtract(datetime, num, :hour), do: subtract(datetime, num, :hours)
  def subtract(datetime, num, :minute), do: subtract(datetime, num, :minutes)
  def subtract(datetime, num, :second), do: subtract(datetime, num, :seconds)
  def subtract(datetime, num, :millisecond), do: subtract(datetime, num, :milliseconds)
  def subtract(datetime, num, :microsecond), do: subtract(datetime, num, :microseconds)


  # Years

  # Base case
  def subtract(%DateTime{year: year} = datetime, num, :years)
  when natural?(num),
  do: %DateTime{datetime | year: year - num}


  # Months

  # Base case
  def subtract(%DateTime{month: month} = datetime, num, :months)
  when natural?(num) and natural?(month - num),
  do: %DateTime{datetime | month: month - num}

  # Many years worth of months
  def subtract(%DateTime{} = datetime, num, :months)
  when positive?(num) and num > 11
  do
    years = floor(num / 12)
    subtract(datetime, years, :years) |> subtract(num - years * 12, :months)
  end

  # Rollover months to the prevous year
  def subtract(%DateTime{year: year, month: month} = datetime, num, :months)
  when positive?(num) and month - num <= 0,
  do: %DateTime{datetime | month: 12 + month - num, year: year - 1}


  # Days

  # Base case
  def subtract(%DateTime{day: day} = datetime, num, :days)
  when natural?(num) and natural?(day - num),
  do: %DateTime{datetime | day: day - num}

  # Many months worth of days
  def subtract(%DateTime{month: month} = datetime, num, :days)
  when positive?(num) and num > days_in_month(month - 1),
  do: subtract(datetime, 1, :months) |> subtract(num - days_in_month(month - 1), :days)

  # Rollover days to the previous month
  def subtract(%DateTime{month: month, day: day} = datetime, num, :days)
  when positive?(num) and day + num >= days_in_month(month - 1),
  do: subtract(%DateTime{datetime | day: days_in_month(month - 1)}, 1, :months) |> subtract(num - day, :days)
end
