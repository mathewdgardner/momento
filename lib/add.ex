defmodule Momento.Add do
  import Momento.Guards

  # Singular to plural
  def add(datetime, num, :year), do: add(datetime, num, :years)
  def add(datetime, num, :month), do: add(datetime, num, :months)
  def add(datetime, num, :day), do: add(datetime, num, :days)
  def add(datetime, num, :hour), do: add(datetime, num, :hours)
  def add(datetime, num, :minute), do: add(datetime, num, :minutes)
  def add(datetime, num, :second), do: add(datetime, num, :seconds)

  # Years
  def add(%DateTime{} = datetime, 0, :years), do: datetime
  def add(%DateTime{year: year} = datetime, num, :years) when positive?(num), do: %DateTime{datetime | year: year + num}


  # Months
  def add(%DateTime{} = datetime, 0, :months), do: datetime

  def add(%DateTime{year: year} = datetime, num, :months)
  when positive?(num) and num >= 12,
  do: add(%DateTime{datetime | year: year + 1}, num - 12, :month)

  def add(%DateTime{month: month} = datetime, num, :months)
  when positive?(num) and month + num <= 12,
  do: %DateTime{datetime | month: month + num}

  def add(%DateTime{year: year, month: month} = datetime, num, :months)
  when positive?(num) and month + num > 12,
  do: %DateTime{datetime | month: month + num - 12, year: year + 1}


  # Days
  def add(%DateTime{} = datetime, 0, :days), do: datetime

  def add(%DateTime{month: month, day: day} = datetime, num, :days)
  when positive?(num) and day + num <= days_in_month(month),
  do: %DateTime{datetime | day: day + num}

  def add(%DateTime{month: month} = datetime, num, :days)
  when positive?(num) and num >= days_in_month(month),
  do: add(datetime, 1, :months) |> add(num - days_in_month(month), :days)

  def add(%DateTime{month: month, day: day} = datetime, num, :days)
  when positive?(num) and day + num > days_in_month(month),
  do: add(add(%DateTime{datetime | day: 1}, 1, :months), -(days_in_month(month) - day - num + 1), :days)


  # Hours
  def add(%DateTime{} = datetime, 0, :hours), do: datetime

  def add(%DateTime{} = datetime, num, :hours)
  when positive?(num) and num > 24,
  do: add(add(datetime, 1, :days), num - 24, :hours)

  def add(%DateTime{hour: hour} = datetime, num, :hours)
  when positive?(num) and num + hour < 24,
  do: %DateTime{datetime | hour: num + hour}

  def add(%DateTime{hour: hour} = datetime, num, :hours)
  when positive?(num) and num + hour >= 24,
  do: add(add(%DateTime{datetime | hour: 0}, 1, :days), -(24 - hour - num), :hours)


  # Seconds
  def add(%DateTime{} = datetime, 0, :minutes), do: datetime

  def add(%DateTime{} = datetime, num, :minutes)
  when positive?(num) and num > 60,
  do: add(add(datetime, 1, :hours), num - 60, :minutes)

  def add(%DateTime{minute: minute} = datetime, num, :minutes)
  when positive?(num) and num + minute < 60,
  do: %DateTime{datetime | minute: num + minute}

  def add(%DateTime{minute: minute} = datetime, num, :minutes)
  when positive?(num) and num + minute >= 60,
  do: add(add(%DateTime{datetime | minute: 0}, 1, :hours), -(60 - minute - num), :minutes)
end
