defmodule Momento.Date do
  import Momento.Guards

  @moduledoc """
  This module holds all the various `date/0`, 'date/1' and `date!/1` methods.
  """

  @doc """
  Get a `DateTime` struct representng now.

  ## Examples

      iex> Momento.date
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 1, hour: 22, microsecond: {732692, 6},
        minute: 56, month: 7, second: 5, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}
  """
  @spec date :: {:ok, DateTime.t}
  def date, do: {:ok, :erlang.system_time(:nano_seconds) |> DateTime.from_unix!(:nanoseconds)}

  @doc """
  Provides a `DateTime` struct from any recognizeable form of input, such as an ISO string or UNIX timestamp.

  ## Examples

      iex> Momento.date("2016-04-20T15:05:13.991Z")
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 20, hour: 15, microsecond: {991000, 6},
        minute: 5, month: 4, second: 13, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}

      ...> Momento.date("2016-04-20")
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 20, hour: 0, microsecond: {0, 6},
        minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}

      ...> Momento.date(1467413967)
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 1, hour: 22, microsecond: {0, 0},
        minute: 59, month: 7, second: 27, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}
  """
  @spec date(any) :: {:ok, DateTime.t}
  def date(%DateTime{} = arg), do: {:ok, arg}

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

        {:ok, %DateTime{
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
        }}

      # ISO date - "2016-04-20"
      Regex.match?(~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/, arg) ->
        [year, month, day] = String.split(arg, "-")

        {:ok, %DateTime{
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
        }}

      true -> {:error, "Unknown date format."}
    end
  end

  # TODO: These are probably wrong
  def date(arg) when is_integer(arg) and arg > 999999999999999999, do: DateTime.from_unix(arg, :nanoseconds)
  def date(arg) when is_integer(arg) and arg > 999999999999999, do: DateTime.from_unix(arg, :microseconds)
  def date(arg) when is_integer(arg) and arg > 999999999999, do: DateTime.from_unix(arg, :milliseconds)
  def date(arg) when is_integer(arg) and positive?(arg), do: DateTime.from_unix(arg, :seconds)

  @doc """
  Shortcut to get a `DateTime` struct representing now.

  ## Examples

      iex> Momento.date!
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 21, microsecond: {0, 0},
       minute: 32, month: 7, second: 15, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """
  @spec date! :: DateTime.t
  def date!, do: ({:ok, datetime} = date; datetime)

  @doc """
  Shortcut to get a `DateTime` struct from any recognizeable form of input, such as an ISO string or UNIX timestamp.

  ## Examples

      iex> Momento.date!("2016-04-20T15:05:13.991Z")
      %DateTime{calendar: Calendar.ISO, day: 20, hour: 15, microsecond: {991000, 6},
       minute: 5, month: 4, second: 13, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}

      ...> Momento.date!("2016-04-20")
      %DateTime{calendar: Calendar.ISO, day: 20, hour: 0, microsecond: {0, 6},
       minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}

      ...> Momento.date!(1467413967)
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 22, microsecond: {0, 0},
       minute: 59, month: 7, second: 27, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """
  @spec date!(any) :: DateTime.t
  def date!(arg) when is_integer(arg), do: ({:ok, datetime} = date(arg); datetime)
end
