defmodule Momento.Format do
  @moduledoc """
  This module holds all the `format/2` method.
  """

  @doc """
  Provide a `DateTime` struct and token string to get back a formatted date/datetime string.

  ## Examples

      iex> Momento.date |> Momento.format("YYYY-MM-DD")
      "2016-07-01"

      ...> Momento.date |> Momento.format("M-D-YY")
      "7-1-16"
  """

  @tokens ~r/YYYY|YY?|MM?M?M?|DD?D?D?|HH?|mm?|ss?|X|x/

  @spec format(DateTime.t, String.t) :: String.t
  # An implementation of the Moment.js formats listed here: http://momentjs.com/docs/#/displaying/format/
  # TODO: Add support for escaping characters within square brackets []
  def format(%DateTime{} = datetime, format_string)
  when is_bitstring(format_string)
  do
    # Split the format_string into pieces by tokens
    Regex.split(@tokens, format_string, include_captures: true, trim: true)

      # Convert each token
      |> Enum.map(fn token ->
        case token do
          # 1970 1971 ... 2029 2030
          "YYYY" -> datetime.year |> Integer.to_string

          # 70 71 ... 29 30
          "YY" -> rem(datetime.year, 100) |> Integer.to_string

          # TODO: 1970 1971 ... 9999 +10000 +10001
          # "Y" -> datetime.year |> Integer.to_string)

          # TODO: January February ... November December
          # "MMMM" -> datetime.month |> Integer.to_string

          # TODO: Jan Feb ... Nov Dec
          # "MMM" -> datetime.month |> Integer.to_string

          # 01 02 ... 11 12
          "MM" -> datetime.month |> Integer.to_string |> String.rjust(2, ?0)

          # 1 2 ... 11 12
          "M" -> datetime.month |> Integer.to_string

          # TODO: 1st 2nd ... 11th 12th
          # "Mo" -> datetime.month |> Integer.to_string

          # TODO: 001 002 ... 364 365
          # "DDDD" -> datetime.day |> Integer.to_string

          # TODO: 1st 2nd ... 364th 365th
          # "DDDo" -> datetime.day |> Integer.to_string

          # TODO: 1 2 ... 364 365
          # "DDD" -> datetime.day |> Integer.to_string

          # 01 02 ... 30 31
          "DD" -> datetime.day |> Integer.to_string |> String.rjust(2, ?0)

          # TODO: 1st 2nd ... 30th 31st
          # "Do" -> datetime.day |> Integer.to_string

          # 1 2 ... 30 31
          "D" -> datetime.day |> Integer.to_string

          # TODO: Sunday Monday ... Friday Saturday
          # "dddd" -> datetime.day |> Integer.to_string

          # TODO: Sun Mon ... Fri Sat
          # "ddd" -> datetime.day |> Integer.to_string

          # TODO: Su Mo ... Fr Sa
          # "dd" -> datetime.day |> Integer.to_string

          # TODO: 0th 1st ... 5th 6th
          # "do" -> datetime.day |> Integer.to_string

          # TODO: 0 1 ... 5 6
          # "d" -> datetime.day |> Integer.to_string

          # 00 01 ... 22 23
          "HH" -> datetime.hour |> Integer.to_string |> String.rjust(2, ?0)

          # 0 1 ... 22 23
          "H" -> datetime.hour |> Integer.to_string

          # TODO: 01 02 ... 11 12
          # "hh" -> datetime.hour |> Integer.to_string

          # TODO: 1 2 ... 11 12
          # "h" -> datetime.hour |> Integer.to_string

          # TODO: 01 02 ... 23 24
          # "kk" -> datetime.hour |> Integer.to_string

          # TODO: 1 2 ... 23 24
          # "k" -> datetime.hour |> Integer.to_string

          # 00 01 ... 58 59
          "mm" -> datetime.minute |> Integer.to_string |> String.rjust(2, ?0)

          # 0 1 ... 58 59
          "m" -> datetime.minute |> Integer.to_string

          # 00 01 ... 58 59
          "ss" -> datetime.second |> Integer.to_string |> String.rjust(2, ?0)

          # 0 1 ... 58 59
          "s" -> datetime.second |> Integer.to_string

          # TODO: 000[0..] 001[0..] ... 998[0..] 999[0..]
          # ~r/S{4,9}/ -> datetime.second |> Integer.to_string

          # TODO: 000 001 ... 998 999
          # "SSS" -> datetime.second |> Integer.to_string

          # TODO: 00 01 ... 98 99
          # "SS" -> datetime.second |> Integer.to_string

          # TODO: 0 1 ... 8 9
          # "S" -> datetime.second |> Integer.to_string

          # TODO: -0700 -0600 ... +0600 +0700
          # "ZZ" -> datetime.time_zone

          # TODO: -07:00 -06:00 ... +06:00 +07:00
          # "Z" -> datetime.time_zone

          # TODO: AM PM
          # "A" -> datetime.hour |> Integer.to_string

          # TODO: am pm
          # "a" -> datetime.hour |> Integer.to_string

          # TODO: 1 2 3 4
          # "Q" -> datetime.month |> Integer.to_string

          # TODO: 1st 2nd 3rd 4th
          # "Qo" -> datetime.month |> Integer.to_string

          # TODO: 1 2 ... 6 7
          # "E" -> datetime

          # TODO: 0 1 ... 5 6
          # "e" -> datetime

          # TODO: 01 02 ... 52 53
          # "WW" -> datetime

          # TODO: 1st 2nd ... 52nd 53rd
          # "Wo" -> datetime

          # TODO: 1 2 ... 52 53
          # "W" -> datetime

          # TODO: 01 02 ... 52 53
          # "ww" -> datetime

          # TODO: 1st 2nd ... 52nd 53rd
          # "wo" -> datetime

          # TODO: 1 2 ... 52 53
          # "w" -> datetime

          # TODO: 1970 1971 ... 2029 2030
          # "GGGG" -> datetime

          # TODO: 70 71 ... 29 30
          # "GG" -> datetime

          # TODO: 1970 1971 ... 2029 2030
          # "gggg" -> datetime

          # TODO: 70 71 ... 29 30
          # "gg" -> datetime

          # TODO: Thursday, September 4 1986 8:30 PM
          # "LLLL" -> datetime

          # TODO: September 4 1986 8:30 PM
          # "LLL" -> datetime

          # TODO: September 4 1986
          # "LL" -> datetime

          # TODO: 8:30:25 PM
          # "LTS" -> datetime

          # TODO: 8:30 PM
          # "LT" -> datetime

          # TODO: 09/04/1986
          # "L" -> datetime

          # TODO: Thu, Sep 4 1986 8:30 PM
          # "llll" -> datetime

          # TODO: Sep 4 1986 8:30 PM
          # "lll" -> datetime

          # TODO: Sep 4 1986
          # "ll" -> datetime

          # TODO: 9/4/1986
          # "l" -> datetime

          # 1360013296
          "X" -> datetime |> DateTime.to_unix |> Integer.to_string

          # 1360013296123
          "x" -> datetime |> DateTime.to_unix(:milliseconds) |> Integer.to_string

          _ -> token
        end
      end)

      # Recombine the pieces
      |> Enum.join
  end
end
