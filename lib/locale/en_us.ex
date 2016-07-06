defmodule Momento.Locale.EN_US do
  @moduledoc """
  Values for english translations.
  """

  @doc """
  Provides english translations of months.

  ## Examples

      iex> Momento.Locale.EN_US.months
      {"January", "February", "March", "April", "May", "June", "July", "August",
       "September", "October", "November", "December"}
  """
  def months do
    {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
  end


  @doc """
  Provides english translations of abbreviated months.

  ## Examples

      iex> Momento.Locale.EN_US.months_short
      {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov",
       "Dec"}
  """
  def months_short do
    {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
  end


  @doc """
  Provides english translations of weekdays.

  ## Examples

      iex> Momento.Locale.EN_US.weekdays
      {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
  """
  def weekdays do
    {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
  end


  @doc """
  Provides english translations of abbreviated weekdays.

  ## Examples

      iex> Momento.Locale.EN_US.weekdays_short
      {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"}
  """
  def weekdays_short do
    {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"}
  end


  @doc """
  Provides english translations of minimally abbreviated weekdays.

  ## Examples

      iex> Momento.Locale.EN_US.weekdays_min
      {"Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"}
  """
  def weekdays_min do
    {"Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"}
  end
end
