defmodule Momento.Date do
  @spec date() :: DateTime.t
  def date, do: DateTime.from_unix!(:erlang.system_time(:nano_seconds), :nanoseconds)

  @spec date(DateTime.t) :: DateTime.t
  def date(%DateTime{} = arg), do: arg

  # TODO: Add timezone support
  @spec date(String.t) :: DateTime.t
  def date(arg) when is_bitstring(arg) do
    cond do
      # ISO8601 - "2016-04-20T15:05:13.991Z"
      Regex.match?(~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}[tT\s][0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}[zZ]$/, arg) ->
        with [date, time]         <- String.split(arg, "T"),
          [year, month, day]      <- String.split(date, "-"),
          [hour, minute, seconds] <- String.split(time, ":"),
          [second, milliseconds]  <- String.split(seconds, "."),
          [millisecond, _]        <- String.split(milliseconds, "Z")
        do
          %DateTime{
            year: String.to_integer(year),
            month: String.to_integer(month),
            day: String.to_integer(day),
            hour: String.to_integer(hour),
            minute: String.to_integer(minute),
            second: String.to_integer(second),
            microsecond: {String.to_integer(millisecond) * 1000, 6},
            std_offset: 0,
            utc_offset: 0,
            time_zone: "Etc/UTC",
            zone_abbr: "UTC"
          }
        end

      # ISO date - "2016-04-20"
      Regex.match?(~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/, arg) ->
        with [year, month, day] <- String.split(arg, "-")
        do
          %DateTime{
            year: String.to_integer(year),
            month: String.to_integer(month),
            day: String.to_integer(day),
            hour: 0,
            minute: 0,
            second: 0,
            microsecond: {0, 6},
            std_offset: 0,
            utc_offset: 0,
            time_zone: "Etc/UTC",
            zone_abbr: "UTC"
          }
        end

      true -> {:error, "Unknown date format."}
    end
  end

  # Unix epoch
  @spec date(integer) :: {:ok, DateTime.t}
  def date(s) when is_integer(s) and s > 999999999999999999, do: DateTime.from_unix(s, :nanoseconds)
  def date(s) when is_integer(s) and s > 999999999999999, do: DateTime.from_unix(s, :microseconds)
  def date(s) when is_integer(s) and s > 999999999999, do: DateTime.from_unix(s, :milliseconds)
  def date(s) when is_integer(s) and s > 999999999, do: DateTime.from_unix(s, :seconds)

  @spec date(integer) :: DateTime.t
  def date!(s), do: ({:ok, datetime} = date(s); datetime)
end
