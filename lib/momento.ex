defmodule Momento do
  require Momento.Guards

  @moduledoc """
  Momento is an Elixir port of [Moment.js](https://github.com/moment/moment) for the purpose of parsing, validating,
  manipulating, and formatting dates.
  """

  @doc """
  Provides a DateTime struct representing the current date and time.

  ## Examples

      iex> Momento.date
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 1, hour: 21, microsecond: {827272, 6},
        minute: 27, month: 7, second: 19, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}
  """
  @spec date :: {:ok, DateTime.t}
  def date, do: Momento.Date.date

  @doc """
  Provides a DateTime struct from any recognizeable form of input, such as an ISO string or UNIX timestamp.

  ## Examples

      Momento.date
      {:ok,
       %DateTime{calendar: Calendar.ISO, day: 1, hour: 21, microsecond: {827272, 6},
        minute: 27, month: 7, second: 19, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}
  """
  @spec date(any) :: {:ok, DateTime.t}
  def date(arg), do: Momento.Date.date(arg)

  @doc """
  Shortcut to get a `DateTime` struct representing now.

  ## Examples

      iex> Momento.date!
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 21, microsecond: {0, 0},
       minute: 32, month: 7, second: 15, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """
  @spec date! :: DateTime.t
  def date!, do: Momento.Date.date!

  @doc """
  Provides a DateTime struct from any recognizeable form of input, such as an ISO string or UNIX timestamp.

  ## Examples

      iex> Momento.date!(1467408735)
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 21, microsecond: {0, 0},
       minute: 32, month: 7, second: 15, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2016, zone_abbr: "UTC"}
  """
  @spec date!(any) :: DateTime.t
  def date!(arg), do: Momento.Date.date!(arg)

  @doc """
  Add a specified amount of time to a given DateTime struct.

  ## Examples
      iex> Momento.date! |> Momento.add(2, :years)
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 21, microsecond: {796482, 6},
       minute: 38, month: 7, second: 18, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2018, zone_abbr: "UTC"}
  """
  @spec add(DateTime.t, integer, atom) :: DateTime.t
  def add(datetime, num, time), do: Momento.Add.add(datetime, num, time)

  @doc """
  Subtract a specified amount of time to a given DateTime struct.

  ## Examples
      iex> Momento.date! |> Momento.subtract(2, :years)
      %DateTime{calendar: Calendar.ISO, day: 1, hour: 21, microsecond: {19292, 6},
       minute: 39, month: 7, second: 11, std_offset: 0, time_zone: "Etc/UTC",
       utc_offset: 0, year: 2014, zone_abbr: "UTC"}
  """
  @spec subtract(DateTime.t, integer, atom) :: DateTime.t
  def subtract(datetime, num, time), do: Momento.Subtract.subtract(datetime, num, time)

  @doc """
  Format a given DateTime struct to a desired date string.

  ## Examples
      iex> Momento.date! |> Momento.format("YYYY-MM-DD")
      "2016-07-01"
  """
  @spec format(DateTime.t, String.t) :: DateTime.t
  def format(datetime, tokens), do: Momento.Format.format(datetime, tokens)
end
