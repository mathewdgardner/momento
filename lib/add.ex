defmodule Momento.Add do
  import Momento.Guards

  # Helpers
  defp floor(float), do: Float.floor(float) |> round
  defp millisecond_factor(precision), do: :math.pow(10, precision - 3) |> round
  defp microsecond_factor(precision), do: :math.pow(10, precision) |> round

  # Singular to plural
  def add(datetime, num, :year), do: add(datetime, num, :years)
  def add(datetime, num, :month), do: add(datetime, num, :months)
  def add(datetime, num, :day), do: add(datetime, num, :days)
  def add(datetime, num, :hour), do: add(datetime, num, :hours)
  def add(datetime, num, :minute), do: add(datetime, num, :minutes)
  def add(datetime, num, :second), do: add(datetime, num, :seconds)
  def add(datetime, num, :millisecond), do: add(datetime, num, :milliseconds)
  def add(datetime, num, :microsecond), do: add(datetime, num, :microseconds)

  # Years
  def add(%DateTime{} = datetime, 0, :years), do: datetime
  def add(%DateTime{year: year} = datetime, num, :years) when positive?(num), do: %DateTime{datetime | year: year + num}


  # Months
  def add(%DateTime{} = datetime, 0, :months), do: datetime

  def add(%DateTime{month: month} = datetime, num, :months)
  when positive?(num) and month + num <= 12,
  do: %DateTime{datetime | month: month + num}

  def add(%DateTime{} = datetime, num, :months)
  when positive?(num) and num > 11
  do
    years = floor(num / 12)
    add(datetime, years, :years) |> add(num - years * 12, :months)
  end

  def add(%DateTime{year: year, month: month} = datetime, num, :months)
  when positive?(num) and month + num > 12,
  do: %DateTime{datetime | month: month + num - 12, year: year + 1}


  # Days
  def add(%DateTime{} = datetime, 0, :days), do: datetime

  def add(%DateTime{month: month, day: day} = datetime, num, :days)
  when positive?(num) and day + num <= days_in_month(month),
  do: %DateTime{datetime | day: day + num}

  def add(%DateTime{month: month} = datetime, num, :days)
  when positive?(num) and num > days_in_month(month),
  do: add(datetime, 1, :months) |> add(num - days_in_month(month), :days)

  def add(%DateTime{month: month, day: day} = datetime, num, :days)
  when positive?(num) and day + num > days_in_month(month),
  do: add(%DateTime{datetime | day: 1}, 1, :months) |> add(-(days_in_month(month) - day - num + 1), :days)


  # Hours
  def add(%DateTime{} = datetime, 0, :hours), do: datetime

  def add(%DateTime{} = datetime, num, :hours)
  when positive?(num) and num > 24
  do
    days = floor(num / 24)
    add(datetime, days, :days) |> add(num - days * 24, :hours)
  end

  def add(%DateTime{hour: hour} = datetime, num, :hours)
  when positive?(num) and num + hour < 24,
  do: %DateTime{datetime | hour: num + hour}

  def add(%DateTime{hour: hour} = datetime, num, :hours)
  when positive?(num) and num + hour >= 24,
  do: add(%DateTime{datetime | hour: 0}, 1, :days) |> add(-(24 - hour - num), :hours)


  # Minutes
  def add(%DateTime{} = datetime, 0, :minutes), do: datetime

  def add(%DateTime{} = datetime, num, :minutes)
  when positive?(num) and num > 60
  do
    hours = floor(num / 60)
    add(datetime, hours, :hours) |> add(num - hours * 60, :minutes)
  end

  def add(%DateTime{minute: minute} = datetime, num, :minutes)
  when positive?(num) and num + minute < 60,
  do: %DateTime{datetime | minute: num + minute}

  def add(%DateTime{minute: minute} = datetime, num, :minutes)
  when positive?(num) and num + minute >= 60,
  do: add(%DateTime{datetime | minute: 0}, 1, :hours) |> add(-(60 - minute - num), :minutes)


  # Seconds
  def add(%DateTime{} = datetime, 0, :seconds), do: datetime

  def add(%DateTime{} = datetime, num, :seconds)
  when positive?(num) and num > 60
  do
    minutes = floor(num / 60)
    add(datetime, minutes, :minutes) |> add(num - minutes * 60, :seconds)
  end

  def add(%DateTime{second: second} = datetime, num, :seconds)
  when positive?(num) and num + second < 60,
  do: %DateTime{datetime | second: num + second}

  def add(%DateTime{second: second} = datetime, num, :seconds)
  when positive?(num) and num + second >= 60,
  do: add(%DateTime{datetime | second: 0}, 1, :minutes) |> add(-(60 - second - num), :seconds)


  # Milliseconds
  def add(%DateTime{} = datetime, 0, :milliseconds), do: datetime

  def add(%DateTime{microsecond: {_, precision}} = datetime, num, :milliseconds)
  when positive?(num) and num > 999 and precision >= 3
  do
    seconds = Float.floor(num / millisecond_factor(precision)) |> round
    add(datetime, seconds, :seconds) |> add(num - seconds * millisecond_factor(precision), :milliseconds)
  end

  def add(%DateTime{microsecond: {microsecond, precision}} = datetime, num, :milliseconds)
  when positive?(num) and num <= 999,
  do: %DateTime{datetime | microsecond: {microsecond + num * millisecond_factor(precision), precision}}


  # Microseconds
  def add(%DateTime{} = datetime, 0, :microseconds), do: datetime

  def add(%DateTime{microsecond: {_, precision}} = datetime, num, :microseconds)
  when positive?(num) and precision === 6 and num > 999999
  do
    seconds = Float.floor(num / microsecond_factor(precision)) |> round
    add(datetime, seconds, :seconds) |> add(num - seconds * microsecond_factor(precision), :microseconds)
  end

  def add(%DateTime{microsecond: {microsecond, precision}} = datetime, num, :microseconds)
  when positive?(num) and precision === 6 and microsecond + num <= 999999,
  do: %DateTime{datetime | microsecond: {microsecond + num, precision}}
end
