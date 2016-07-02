defmodule Momento.Date do
  import Momento.Guards

  @moduledoc """
  This module holds all the various `date/0`, 'date/1' and `date!/1` methods.
  """

  @doc """
  Get a `DateTime` struct representng now.

  ## Examples

      iex> Momento.date
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 22, microsecond: {732692, 6},
       minute: 56, month: 7, second: 5, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """
  @spec date() :: DateTime.t
  def date, do: DateTime.from_unix!(:erlang.system_time(:nano_seconds), :nanoseconds)


  @doc """
  Spits back the given `DateTime` struct, for convenience.

  ## Examples

      iex> Momento.date |> Momento.date
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 22, microsecond: {259334, 6},
       minute: 56, month: 7, second: 46, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """
  @spec date(DateTime.t) :: DateTime.t
  def date(%DateTime{} = arg), do: arg

  @doc """
  Get a `DateTime` struct by parsing a given string. Currently, only ISO8601 and ISO date strings are supported.

  ## Examples

      iex> Momento.date("2016-04-20T15:05:13.991Z")
      %DateTime{calendar: Calendar.ISO, day: 20, hour: 15, microsecond: {991000, 6},
       minute: 5, month: 4, second: 13, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}

      iex> Momento.date("2016-04-20")
      %DateTime{calendar: Calendar.ISO, day: 20, hour: 0, microsecond: {0, 6},
       minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """
  @spec date(String.t) :: DateTime.t
  # TODO: Add timezone support
  # TODO: Add more formats to parse
  def date(arg) when is_bitstring(arg) do
    cond do
      # ISO8601 - "2016-04-20T15:05:13.991Z"
      Regex.match?(~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}[tT\s][0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}[zZ]$/, arg) ->
        [date, time] = String.split(arg, "T")
        [year, month, day] = String.split(date, "-")
        [hour, minute, seconds] = String.split(time, ":")
        [second, milliseconds] = String.split(seconds, ".")
        [millisecond, _] = String.split(milliseconds, "Z")

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

      # ISO date - "2016-04-20"
      Regex.match?(~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/, arg) ->
        [year, month, day] = String.split(arg, "-")

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

      true -> {:error, "Unknown date format."}
    end
  end

  @doc """
  Get a `DateTime` struct from a UNIX timestamp. You can provide `seconds`, `milliseconds`,  `microseconds` and
  `nanoseconds`.

  ## Examples

      iex> Momento.date(1467413967)
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 1, hour: 22, microsecond: {0, 0},
        minute: 59, month: 7, second: 27, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}

      ...> Momento.date(1467414084898)
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 1, hour: 23, microsecond: {898000, 3},
        minute: 1, month: 7, second: 24, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}

      ...> Momento.date(1467414112393174)
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 1, hour: 23, microsecond: {393174, 6},
        minute: 1, month: 7, second: 52, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}

      ...> Momento.date(1467414144089210599)
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 1, hour: 23, microsecond: {89210, 6},
        minute: 2, month: 7, second: 24, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}
  """
  # TODO: This is probably wrong
  @spec date(integer) :: {:ok, DateTime.t}
  def date(s) when is_integer(s) and s > 999999999999999999, do: DateTime.from_unix(s, :nanoseconds)
  def date(s) when is_integer(s) and s > 999999999999999, do: DateTime.from_unix(s, :microseconds)
  def date(s) when is_integer(s) and s > 999999999999, do: DateTime.from_unix(s, :milliseconds)
  def date(s) when is_integer(s) and positive?(s), do: DateTime.from_unix(s, :seconds)

  @doc """
  Get a `DateTime` struct from a UNIX timestamp without the tuple. You can provide `seconds`, `milliseconds`,
  `microseconds` and `nanoseconds`.

  ## Examples

      iex> Momento.date!(1467413967)
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 22, microsecond: {0, 0},
       minute: 59, month: 7, second: 27, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """
  @spec date(integer) :: DateTime.t
  def date!(s), do: ({:ok, datetime} = date(s); datetime)
end
