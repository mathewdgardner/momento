defmodule Momento.Format do
  @doc """
  Provide a `DateTime` struct and token string to get back a formatted date/datetime string.

  ## Examples

      iex> use Momento
      ...> Momento.date |> Momento.format("YYYY-MM-DD")
      "2016-07-01"

      ...> Momento.date |> Momento.format("M-D-YY")
      "7-1-16"
  """
  @spec format(DateTime.t, String.t) :: String.t
  def format(%DateTime{} = datetime, tokens)
  when is_bitstring(tokens)
  do
    # A naive implementation of the Moment.js formats listed here: http://momentjs.com/docs/#/displaying/format/
    # 1970 1971 ... 2029 2030
    with tokens <- replace(tokens, "YYYY", datetime.year |> Integer.to_string),

      # 70 71 ... 29 30
      tokens <- replace(tokens, "YY", rem(datetime.year, 100) |> Integer.to_string),

      # TODO: 1970 1971 ... 9999 +10000 +10001
      # tokens <- String.replace(tokens, "Y", datetime.year |> Integer.to_string),

      # TODO: January February ... November December
      # tokens <- String.replace(tokens, "MMMM", datetime.month |> Integer.to_string),

      # TODO: Jan Feb ... Nov Dec
      # tokens <- String.replace(tokens, "MMM", datetime.month |> Integer.to_string),

      # 01 02 ... 11 12
      tokens <- replace(tokens, "MM", datetime.month |> Integer.to_string |> String.rjust(2, ?0)),

      # 1 2 ... 11 12
      tokens <- replace(tokens, "M", datetime.month |> Integer.to_string),

      # TODO: 1st 2nd ... 11th 12th
      # tokens <- replace(tokens, "Mo", datetime.month |> Integer.to_string),

      # TODO: 001 002 ... 364 365
      # tokens <- replace(tokens, "DDDD", datetime.day |> Integer.to_string),

      # TODO: 1st 2nd ... 364th 365th
      # tokens <- replace(tokens, "DDDo", datetime.day |> Integer.to_string),

      # TODO: 1 2 ... 364 365
      # tokens <- replace(tokens, "DDD", datetime.day |> Integer.to_string),

      # 01 02 ... 30 31
      tokens <- replace(tokens, "DD", datetime.day |> Integer.to_string |> String.rjust(2, ?0)),

      # TODO: 1st 2nd ... 30th 31st
      # tokens <- replace(tokens, "Do", datetime.day |> Integer.to_string),

      # 1 2 ... 30 31
      tokens <- replace(tokens, "D", datetime.day |> Integer.to_string),

      # TODO: Sunday Monday ... Friday Saturday
      # tokens <- replace(tokens, "dddd", datetime.day |> Integer.to_string),

      # TODO: Sun Mon ... Fri Sat
      # tokens <- replace(tokens, "ddd", datetime.day |> Integer.to_string),

      # TODO: Su Mo ... Fr Sa
      # tokens <- replace(tokens, "dd", datetime.day |> Integer.to_string),

      # TODO: 0th 1st ... 5th 6th
      # tokens <- replace(tokens, "do", datetime.day |> Integer.to_string),

      # TODO: 0 1 ... 5 6
      # tokens <- replace(tokens, "d", datetime.day |> Integer.to_string),

      # 00 01 ... 22 23
      tokens <- replace(tokens, "HH", datetime.hour |> Integer.to_string |> String.rjust(2, ?0)),

      # 0 1 ... 22 23
      tokens <- replace(tokens, "H", datetime.hour |> Integer.to_string),

      # TODO: 01 02 ... 11 12
      # tokens <- replace(tokens, "hh", datetime.hour |> Integer.to_string),

      # TODO: 1 2 ... 11 12
      # tokens <- replace(tokens, "h", datetime.hour |> Integer.to_string),

      # TODO: 01 02 ... 23 24
      # tokens <- replace(tokens, "kk", datetime.hour |> Integer.to_string),

      # TODO: 1 2 ... 23 24
      # tokens <- replace(tokens, "k", datetime.hour |> Integer.to_string),

      # 00 01 ... 58 59
      tokens <- replace(tokens, "mm", datetime.minute |> Integer.to_string |> String.rjust(2, ?0)),

      # 0 1 ... 58 59
      tokens <- replace(tokens, "m", datetime.minute |> Integer.to_string),

      # 00 01 ... 58 59
      tokens <- replace(tokens, "ss", datetime.second |> Integer.to_string |> String.rjust(2, ?0)),

      # 0 1 ... 58 59
      tokens <- replace(tokens, "s", datetime.second |> Integer.to_string),

      # TODO: 000[0..] 001[0..] ... 998[0..] 999[0..]
      # tokens <- replace(tokens, ~r/S{4,9}/, datetime.second |> Integer.to_string),

      # TODO: 000 001 ... 998 999
      # tokens <- replace(tokens, "SSS", datetime.second |> Integer.to_string),

      # TODO: 00 01 ... 98 99
      # tokens <- replace(tokens, "SS", datetime.second |> Integer.to_string),

      # TODO: 0 1 ... 8 9
      # tokens <- replace(tokens, "S", datetime.second |> Integer.to_string),

      # TODO: -0700 -0600 ... +0600 +0700
      # tokens <- replace(tokens, "ZZ", datetime.time_zone),

      # TODO: -07:00 -06:00 ... +06:00 +07:00
      # tokens <- replace(tokens, "Z", datetime.time_zone),

      # TODO: AM PM
      # tokens <- replace(tokens, "A", datetime.hour |> Integer.to_string),

      # TODO: am pm
      # tokens <- replace(tokens, "a", datetime.hour |> Integer.to_string),

      # TODO: 1 2 3 4
      # tokens <- replace(tokens, "Q", datetime.month |> Integer.to_string),

      # TODO: 1st 2nd 3rd 4th
      # tokens <- replace(tokens, "Qo", datetime.month |> Integer.to_string),

      # TODO: 1 2 ... 6 7
      # tokens <- replace(tokens, "E", datetime),

      # TODO: 0 1 ... 5 6
      # tokens <- replace(tokens, "e", datetime),

      # TODO: 01 02 ... 52 53
      # tokens <- replace(tokens, "WW", datetime),

      # TODO: 1st 2nd ... 52nd 53rd
      # tokens <- replace(tokens, "Wo", datetime),

      # TODO: 1 2 ... 52 53
      # tokens <- replace(tokens, "W", datetime),

      # TODO: 01 02 ... 52 53
      # tokens <- replace(tokens, "ww", datetime),

      # TODO: 1st 2nd ... 52nd 53rd
      # tokens <- replace(tokens, "wo", datetime),

      # TODO: 1 2 ... 52 53
      # tokens <- replace(tokens, "w", datetime),

      # TODO: 1970 1971 ... 2029 2030
      # tokens <- replace(tokens, "GGGG", datetime),

      # TODO: 70 71 ... 29 30
      # tokens <- replace(tokens, "GG", datetime),

      # TODO: 1970 1971 ... 2029 2030
      # tokens <- replace(tokens, "gggg", datetime),

      # TODO: 70 71 ... 29 30
      # tokens <- replace(tokens, "gg", datetime),

      # 1360013296
      tokens <- replace(tokens, "X", datetime |> DateTime.to_unix |> Integer.to_string),

      # 1360013296123
      tokens <- replace(tokens, "x", datetime |> DateTime.to_unix(:milliseconds) |> Integer.to_string)

    do
      tokens
    end
  end

  @spec replace(String.t, String.t, String.t) :: String.t
  defp replace(tokens, token, value) do
    try do
      String.replace(tokens, token, value)
    rescue
      _ in FunctionClauseError -> tokens
    end
  end
end
