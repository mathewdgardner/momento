## Momento

Momento is an Elixir port of [Moment.js](https://github.com/moment/moment) for the purpose of parsing, validating, manipulating, and formatting dates.

### Getting started

### Usage

```elixir
> use Momento
> datetime = Momento.date
%DateTime{calendar: Calendar.ISO, day: 1, hour: 20, microsecond: {904217, 6},
 minute: 44, month: 7, second: 32, std_offset: 0, time_zone: "Etc/UTC",
 utc_offset: 0, year: 2016, zone_abbr: "UTC"}

> Momento.date |> Momento.add(5, :years)
%DateTime{calendar: Calendar.ISO, day: 1, hour: 20, microsecond: {730106, 6},
 minute: 45, month: 7, second: 57, std_offset: 0, time_zone: "Etc/UTC",
 utc_offset: 0, year: 2021, zone_abbr: "UTC"}

> Momento.date |> Momento.add(5, :years) |> Momento.add(8, :months)
%DateTime{calendar: Calendar.ISO, day: 1, hour: 20, microsecond: {32939, 6},
 minute: 46, month: 1, second: 24, std_offset: 0, time_zone: "Etc/UTC",
 utc_offset: 0, year: 2022, zone_abbr: "UTC"}

> Momento.date |> Momento.subtract(1, :days) |> Momento.subtract(3, :hours) |> Momento.add(15, :minutes)
%DateTime{calendar: Calendar.ISO, day: 0, hour: 18, microsecond: {164079, 6},
 minute: 4, month: 7, second: 13, std_offset: 0, time_zone: "Etc/UTC",
 utc_offset: 0, year: 2016, zone_abbr: "UTC"}

> Momento.date |> Momento.format("YYYY-MM-DD")
"2016-07-01"

> Momento.date |> Momento.format("x")
"1467406270"
```

### Installation

[Available in Hex](https://hex.pm/packages/momento), the package can be installed as:

  1. Add `momento` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:momento, "~> 0.1.0"}]
    end
    ```

  2. Ensure `momento` is started before your application:

    ```elixir
    def application do
      [applications: [:momento]]
    end
    ```

### Roadmap

Things that need to be added for this library to be most useful:

  1. Implement more format tokens
  2. Add timezone support
  3. Implement leaps
  4. Localization
  5. Other useful [Moment.js](https://github.com/moment/moment) things

### License

This software is licensed under [the MIT license](LICENSE.md).
