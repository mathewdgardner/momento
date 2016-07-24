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

  @tokens ~r/A|a|YYYY|YY?|Mo|MM?M?M?|Do|do|DD?D?D?|dd?d?d?|HH?|hh?|LL?L?L?|ll?l?l?|mm?|Qo|Q|ss?|X|x/

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

          # January February ... November December
          "MMMM" -> datetime.month |> get_month_name

          # Jan Feb ... Nov Dec
          "MMM" -> datetime.month |> get_month_name(:MMM)

          # 01 02 ... 11 12
          "MM" -> datetime.month |> Integer.to_string |> String.rjust(2, ?0)

          # 1 2 ... 11 12
          "M" -> datetime.month |> Integer.to_string

          # 1st 2nd ... 11th 12th
          "Mo" -> datetime.month |> get_ordinal_form

          # TODO: 001 002 ... 364 365
          # "DDDD" -> datetime.day |> Integer.to_string

          # TODO: 1st 2nd ... 364th 365th
          # "DDDo" -> datetime.day |> Integer.to_string

          # TODO: 1 2 ... 364 365
          # "DDD" -> datetime.day |> Integer.to_string

          # 01 02 ... 30 31
          "DD" -> datetime.day |> Integer.to_string |> String.rjust(2, ?0)

          # 1st 2nd ... 30th 31st
          "Do" -> datetime.day |> get_ordinal_form

          # 1 2 ... 30 31
          "D" -> datetime.day |> Integer.to_string

          # Sunday Monday ... Friday Saturday
          "dddd" -> datetime |> get_day_of_the_week(:dddd)

          # Sun Mon ... Fri Sat
          "ddd" -> datetime |> get_day_of_the_week(:ddd)

          # Su Mo ... Fr Sa
          "dd" -> datetime |> get_day_of_the_week(:dd)

          # 0th 1st ... 5th 6th
          "do" -> datetime |> get_day_of_the_week(:do)

          # 0 1 ... 5 6
          "d" -> datetime |> get_day_of_the_week

          # 00 01 ... 22 23
          "HH" -> datetime.hour |> Integer.to_string |> String.rjust(2, ?0)

          # 0 1 ... 22 23
          "H" -> datetime.hour |> Integer.to_string

          # 01 02 ... 11 12
          "hh" -> datetime.hour |> twelve_hour_format(:hh)

          # 1 2 ... 11 12
          "h" -> datetime.hour |> twelve_hour_format

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

          # AM PM
          "A" -> get_am_pm(datetime.hour)

          # am pm
          "a" -> get_am_pm(datetime.hour, :a)

          # 1 2 3 4
          "Q" -> datetime.month |> get_quarter

          # 1st 2nd 3rd 4th
          "Qo" -> datetime.month |> get_quarter(:Qo)

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

          # Thursday, September 4 1986 8:30 PM
          "LLLL" -> Momento.format(datetime, "dddd, MMMM D YYYY h:#{pad_leading_zero(datetime.minute)} A")

          # September 4 1986 8:30 PM
          "LLL" -> Momento.format(datetime, "MMMM D YYYY h:#{pad_leading_zero(datetime.minute)} A")

          # September 4 1986
          "LL" -> Momento.format(datetime, "MMMM D YYYY")

          # TODO: 8:30:25 PM
          # "LTS" -> datetime

          # TODO: 8:30 PM
          # "LT" -> datetime

          # 09/04/1986
          "L" -> Momento.format(datetime, "MM/DD/YYYY")

          # Thu, Sep 4 1986 8:30 PM
          "llll" -> Momento.format(datetime, "ddd, MMM D YYYY h:#{pad_leading_zero(datetime.minute)} A")

          # Sep 4 1986 8:30 PM
          "lll" -> Momento.format(datetime, "MMM D YYYY h:#{pad_leading_zero(datetime.minute)} A")

          # Sep 4 1986
          "ll" -> Momento.format(datetime, "MMM D YYYY")

          # 9/4/1986
          "l" -> Momento.format(datetime, "M/D/YYYY")

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

  defp calculate_day_of_the_week(datetime) do
    month_offsets = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4}
    year = 
     cond do
       (datetime.month < 3) -> datetime.year - 1
       true -> datetime.year  
     end
     (year + div(year, 4) - div(year, 100) + div(year, 400) + elem(month_offsets, datetime.month - 1) + datetime.day)
     |> rem(7)    
  end

  defp get_am_pm(hour, token \\ :A) do
    am_pm = if hour >= 12, do: "PM", else: "AM"
    case token do
      :a -> String.downcase(am_pm)
       _ -> am_pm 
    end
  end

  defp get_day_of_the_week(datetime, token \\ :d) do
    days_of_a_week = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
    integer_day_of_the_week = calculate_day_of_the_week(datetime)

     case token do
      :dddd -> elem(days_of_a_week, integer_day_of_the_week)
      :ddd -> elem(days_of_a_week, integer_day_of_the_week) |> String.slice(0..2)
      :dd -> elem(days_of_a_week, integer_day_of_the_week) |> String.slice(0..1)
      :do -> get_ordinal_form(integer_day_of_the_week)
      _  -> integer_day_of_the_week |> Integer.to_string 
     end
  end

  defp get_month_name(month_number, token \\ :MMMM) do
    month_name = elem({"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}, month_number-1)
    case token do
      :MMM -> String.slice(month_name, 0..2)
       _ -> month_name
    end
  end

  defp get_ordinal_form(number) do
    number_rem_hundred = rem(number, 100)
    ordinal_form = 
      if number_rem_hundred == 11 || number_rem_hundred == 12 || number_rem_hundred == 13 do
        "th"
      else
        number_rem_ten = rem(number, 10)
          cond do
            number_rem_ten == 1 -> "st"
            number_rem_ten == 2 -> "nd"
            number_rem_ten == 3 -> "rd"
            true -> "th"
          end      
      end
    Integer.to_string(number) <> ordinal_form 
  end

  defp get_quarter(month, token \\ :Q) do
    quarter = 
      cond do
        month >= 1 && month <= 3  -> 1
        month >= 4 && month <= 6  -> 2
        month >= 7 && month <= 9  -> 3
        month >= 10 && month <= 12  -> 4  
      end
    case token do
      :Qo -> get_ordinal_form(quarter)
       _ -> Integer.to_string(quarter)  
    end
  end

  defp twelve_hour_format(hour, token \\ :h) do
    adjusted_hour = 
      cond do
        hour >= 13 -> hour - 12
        hour == 0 -> 12
        true -> hour
      end
    adjusted_hour = Integer.to_string(adjusted_hour)  
    case token do
      :hh -> adjusted_hour |> String.pad_leading(2, "0")
      _ -> adjusted_hour
    end
  end

  defp pad_leading_zero(number) do
    number |> Integer.to_string |> String.pad_leading(2, "0")
  end
end
