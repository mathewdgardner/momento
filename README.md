## Momento

[![master](https://circleci.com/gh/mathewdgardner/momento.svg?style=shield&circle-token=b7acdd3d8650f741723674973a0776d652f02e14)](https://circleci.com/gh/mathewdgardner/momento)
[![coverage](https://coveralls.io/repos/github/mathewdgardner/momento/badge.svg?branch=master)](https://coveralls.io/github/mathewdgardner/momento?branch=master)
[![docs](https://inch-ci.org/github/mathewdgardner/momento.svg)](http://inch-ci.org/github/mathewdgardner/momento)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/mathewdgardner/momento/master/LICENSE)
[![hex](https://img.shields.io/hexpm/v/momento.svg)](https://hex.pm/packages/momento)
[![gitter](https://badges.gitter.im/mathewdgardner/momento.png)](https://gitter.im/mathewdgardner/momento)

Momento is an Elixir port of [Moment.js](https://github.com/moment/moment) for the purpose of parsing, validating, manipulating, and formatting dates.

### Getting started

### Installation

[Available in Hex](https://hex.pm/packages/momento), the package can be installed as:

  1. Add `momento` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:momento, "~> 0.1.1"}]
    end
    ```

  2. Ensure `momento` is started before your application:

    ```elixir
    def application do
      [applications: [:momento]]
    end
    ```

### Usage

```elixir
> import Momento
> datetime = date!
%DateTime{calendar: Calendar.ISO, day: 1, hour: 20, microsecond: {904217, 6},
 minute: 44, month: 7, second: 32, std_offset: 0, time_zone: "Etc/UTC",
 utc_offset: 0, year: 2016, zone_abbr: "UTC"}

> date! |> add(5, :years)
%DateTime{calendar: Calendar.ISO, day: 1, hour: 20, microsecond: {730106, 6},
 minute: 45, month: 7, second: 57, std_offset: 0, time_zone: "Etc/UTC",
 utc_offset: 0, year: 2021, zone_abbr: "UTC"}

> date! |> add(5, :years) |> add(8, :months)
%DateTime{calendar: Calendar.ISO, day: 1, hour: 20, microsecond: {32939, 6},
 minute: 46, month: 1, second: 24, std_offset: 0, time_zone: "Etc/UTC",
 utc_offset: 0, year: 2022, zone_abbr: "UTC"}

> date! |> subtract(1, :days) |> subtract(3, :hours) |> add(15, :minutes)
%DateTime{calendar: Calendar.ISO, day: 0, hour: 18, microsecond: {164079, 6},
 minute: 4, month: 7, second: 13, std_offset: 0, time_zone: "Etc/UTC",
 utc_offset: 0, year: 2016, zone_abbr: "UTC"}

> date! |> format("YYYY-MM-DD")
"2016-07-01"

> date! |> format("x")
"1467406270"
```

### Roadmap

Things that need to be added for this library to be most useful:

  1. Implement more format tokens
  2. Add timezone support
  3. Implement leaps
  4. Localization
  5. Other useful [Moment.js](https://github.com/moment/moment) things

### Contributing

Making a date time library is a tall order. I need help if we are going to make this work. I started this project in an effort to learn Elixir so I'm sure there are many improvements in the existing codebase that can be made. There are probably bugs and generally bad Elixir patterns. I also place `TODO:`s everywhere so feel free to tackle them or any Enhancement/Bug issues.

### License

This software is licensed under [the MIT license](LICENSE.md).
