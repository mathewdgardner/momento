defmodule Momento.Date do
  # date/0
  def date do
    DateTime.from_unix!(:erlang.system_time(:nano_seconds), :nanoseconds)
  end

  # date/1
  def date(%DateTime{} = arg), do: arg

  # def date(arg) when is_bitstring(arg) do
  #   cond do
  #     # ISO8601 - "2016-04-20T15:05:13.991Z"
  #     # TODO: try to use with
  #     Regex.match?(~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}[tT\s][0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}[zZ]$/, arg) ->
  #       [date, time] = String.split(arg, "T")
  #       [year, month, day] = String.split(date, "-")
  #       [hour, minute, seconds] = String.split(time, ":")
  #       [second, milliseconds] = String.split(seconds, ".")
  #       [millisecond, _] = String.split(milliseconds, "Z")
  #       %Momento{year: year, month: month, day: day, hour: hour, minute: minute, second: second, millisecond: millisecond}
  #
  #     # ISO date - "2016-04-20"
  #     Regex.match?(~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/, arg) ->
  #       [year, month, day] = String.split(date, "-")
  #       %Momento{year: year, month: month, day: day}
  #
  #     true -> {:error, "Unknown date format."}
  #   end
  # end

  # Unix epoch
  def date(s) when is_integer(s) and s > 999999999999999999, do: DateTime.from_unix(s, :nanoseconds)
  def date(s) when is_integer(s) and s > 999999999999999, do: DateTime.from_unix(s, :microseconds)
  def date(s) when is_integer(s) and s > 999999999999, do: DateTime.from_unix(s, :milliseconds)
  def date(s) when is_integer(s) and s > 999999999, do: DateTime.from_unix(s, :seconds)
end
