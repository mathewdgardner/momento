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
  @spec format(DateTime.t, String.t) :: String.t
  # TODO: Add support for escaping characters within square brackets []
  def format(%DateTime{} = datetime, tokens)
  when is_bitstring(tokens)
  do
    # A naive implementation of the Moment.js formats listed here: http://momentjs.com/docs/#/displaying/format/
    # 1970 1971 ... 2029 2030
    with tokens <- String.replace(tokens, "YYYY", datetime.year |> Integer.to_string),

      # 70 71 ... 29 30
      tokens <- String.replace(tokens, "YY", rem(datetime.year, 100) |> Integer.to_string),

      # TODO: 1970 1971 ... 9999 +10000 +10001
      # tokens <- String.String.replace(tokens, "Y", datetime.year |> Integer.to_string),

      # TODO: January February ... November December
      # tokens <- String.String.replace(tokens, "MMMM", datetime.month |> Integer.to_string),

      # TODO: Jan Feb ... Nov Dec
      # tokens <- String.String.replace(tokens, "MMM", datetime.month |> Integer.to_string),

      # 01 02 ... 11 12
      tokens <- String.replace(tokens, "MM", datetime.month |> Integer.to_string |> String.rjust(2, ?0)),

      # 1 2 ... 11 12
      tokens <- String.replace(tokens, "M", datetime.month |> Integer.to_string),

      # TODO: 1st 2nd ... 11th 12th
      # tokens <- String.replace(tokens, "Mo", datetime.month |> Integer.to_string),

      # TODO: 001 002 ... 364 365
      # tokens <- String.replace(tokens, "DDDD", datetime.day |> Integer.to_string),

      # TODO: 1st 2nd ... 364th 365th
      # tokens <- String.replace(tokens, "DDDo", datetime.day |> Integer.to_string),

      # TODO: 1 2 ... 364 365
      # tokens <- String.replace(tokens, "DDD", datetime.day |> Integer.to_string),

      # 01 02 ... 30 31
      tokens <- String.replace(tokens, "DD", datetime.day |> Integer.to_string |> String.rjust(2, ?0)),

      # TODO: 1st 2nd ... 30th 31st
      # tokens <- String.replace(tokens, "Do", datetime.day |> Integer.to_string),

      # 1 2 ... 30 31
      tokens <- String.replace(tokens, "D", datetime.day |> Integer.to_string),

      # TODO: Sunday Monday ... Friday Saturday
      # tokens <- String.replace(tokens, "dddd", datetime.day |> Integer.to_string),

      # TODO: Sun Mon ... Fri Sat
      # tokens <- String.replace(tokens, "ddd", datetime.day |> Integer.to_string),

      # TODO: Su Mo ... Fr Sa
      # tokens <- String.replace(tokens, "dd", datetime.day |> Integer.to_string),

      # TODO: 0th 1st ... 5th 6th
      # tokens <- String.replace(tokens, "do", datetime.day |> Integer.to_string),

      # TODO: 0 1 ... 5 6
      # tokens <- String.replace(tokens, "d", datetime.day |> Integer.to_string),

      # 00 01 ... 22 23
      tokens <- String.replace(tokens, "HH", datetime.hour |> Integer.to_string |> String.rjust(2, ?0)),

      # 0 1 ... 22 23
      tokens <- String.replace(tokens, "H", datetime.hour |> Integer.to_string),

      # TODO: 01 02 ... 11 12
      # tokens <- String.replace(tokens, "hh", datetime.hour |> Integer.to_string),

      # TODO: 1 2 ... 11 12
      # tokens <- String.replace(tokens, "h", datetime.hour |> Integer.to_string),

      # TODO: 01 02 ... 23 24
      # tokens <- String.replace(tokens, "kk", datetime.hour |> Integer.to_string),

      # TODO: 1 2 ... 23 24
      # tokens <- String.replace(tokens, "k", datetime.hour |> Integer.to_string),

      # 00 01 ... 58 59
      tokens <- String.replace(tokens, "mm", datetime.minute |> Integer.to_string |> String.rjust(2, ?0)),

      # 0 1 ... 58 59
      tokens <- String.replace(tokens, "m", datetime.minute |> Integer.to_string),

      # 00 01 ... 58 59
      tokens <- String.replace(tokens, "ss", datetime.second |> Integer.to_string |> String.rjust(2, ?0)),

      # 0 1 ... 58 59
      tokens <- String.replace(tokens, "s", datetime.second |> Integer.to_string),

      # TODO: 000[0..] 001[0..] ... 998[0..] 999[0..]
      # tokens <- String.replace(tokens, ~r/S{4,9}/, datetime.second |> Integer.to_string),

      # TODO: 000 001 ... 998 999
      # tokens <- String.replace(tokens, "SSS", datetime.second |> Integer.to_string),

      # TODO: 00 01 ... 98 99
      # tokens <- String.replace(tokens, "SS", datetime.second |> Integer.to_string),

      # TODO: 0 1 ... 8 9
      # tokens <- String.replace(tokens, "S", datetime.second |> Integer.to_string),

      # TODO: -0700 -0600 ... +0600 +0700
      # tokens <- String.replace(tokens, "ZZ", datetime.time_zone),

      # TODO: -07:00 -06:00 ... +06:00 +07:00
      # tokens <- String.replace(tokens, "Z", datetime.time_zone),

      # TODO: AM PM
      # tokens <- String.replace(tokens, "A", datetime.hour |> Integer.to_string),

      # TODO: am pm
      # tokens <- String.replace(tokens, "a", datetime.hour |> Integer.to_string),

      # TODO: 1 2 3 4
      # tokens <- String.replace(tokens, "Q", datetime.month |> Integer.to_string),

      # TODO: 1st 2nd 3rd 4th
      # tokens <- String.replace(tokens, "Qo", datetime.month |> Integer.to_string),

      # TODO: 1 2 ... 6 7
      # tokens <- String.replace(tokens, "E", datetime),

      # TODO: 0 1 ... 5 6
      # tokens <- String.replace(tokens, "e", datetime),

      # TODO: 01 02 ... 52 53
      # tokens <- String.replace(tokens, "WW", datetime),

      # TODO: 1st 2nd ... 52nd 53rd
      # tokens <- String.replace(tokens, "Wo", datetime),

      # TODO: 1 2 ... 52 53
      # tokens <- String.replace(tokens, "W", datetime),

      # TODO: 01 02 ... 52 53
      # tokens <- String.replace(tokens, "ww", datetime),

      # TODO: 1st 2nd ... 52nd 53rd
      # tokens <- String.replace(tokens, "wo", datetime),

      # TODO: 1 2 ... 52 53
      # tokens <- String.replace(tokens, "w", datetime),

      # TODO: 1970 1971 ... 2029 2030
      # tokens <- String.replace(tokens, "GGGG", datetime),

      # TODO: 70 71 ... 29 30
      # tokens <- String.replace(tokens, "GG", datetime),

      # TODO: 1970 1971 ... 2029 2030
      # tokens <- String.replace(tokens, "gggg", datetime),

      # TODO: 70 71 ... 29 30
      # tokens <- String.replace(tokens, "gg", datetime),

      # TODO: Thursday, September 4 1986 8:30 PM
      # tokens <- String.replace(tokens, "LLLL", datetime),

      # TODO: September 4 1986 8:30 PM
      # tokens <- String.replace(tokens, "LLL", datetime),

      # TODO: September 4 1986
      # tokens <- String.replace(tokens, "LL", datetime),

      # TODO: 8:30:25 PM
      # tokens <- String.replace(tokens, "LTS", datetime),

      # TODO: 8:30 PM
      # tokens <- String.replace(tokens, "LT", datetime),

      # TODO: 09/04/1986
      # tokens <- String.replace(tokens, "L", datetime),

      # TODO: Thu, Sep 4 1986 8:30 PM
      # tokens <- String.replace(tokens, "llll", datetime),

      # TODO: Sep 4 1986 8:30 PM
      # tokens <- String.replace(tokens, "lll", datetime),

      # TODO: Sep 4 1986
      # tokens <- String.replace(tokens, "ll", datetime),

      # TODO: 9/4/1986
      # tokens <- String.replace(tokens, "l", datetime),

      # 1360013296
      tokens <- String.replace(tokens, "X", datetime |> DateTime.to_unix |> Integer.to_string),

      # 1360013296123
      tokens <- String.replace(tokens, "x", datetime |> DateTime.to_unix(:milliseconds) |> Integer.to_string)

    do
      tokens
    end
  end
end
