defmodule AddSpec do
  require Momento
  require Momento.Guards
  use ESpec

  describe "add" do
    describe "years" do
      before do
        {:shared, datetime: %DateTime{Momento.date | year: 2016}}
      end

      it "should add nothing" do
        num = 0
        datetime = Momento.add(shared.datetime, num, :years)

        expect(datetime.year) |> to(eq shared.datetime.year + num)
      end

      it "should add some years" do
        num = 5
        datetime = Momento.add(shared.datetime, num, :years)

        expect(datetime.year) |> to(eq shared.datetime.year + num)
      end
    end

    describe "months" do
      before do
        {:shared, datetime: %DateTime{Momento.date | month: 6}}
      end

      it "should add nothing" do
        months = 0
        datetime = Momento.add(shared.datetime, months, :months)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add months without rollover" do
        months = 3
        datetime = Momento.add(shared.datetime, months, :months)

        expect(datetime.year) |> to(eq shared.datetime.year)
        expect(datetime.month) |> to(eq shared.datetime.month + months)
      end

      it "should add months and rollover years" do
        months = 19
        datetime = Momento.add(shared.datetime, months, :months)

        expect(datetime.year) |> to(eq shared.datetime.year + 2)
        expect(datetime.month) |> to(eq 1)
      end

      it "should only add years" do
        months = 24
        years = 24 / 12
        datetime = Momento.add(shared.datetime, months, :months)

        expect(datetime.year) |> to(eq shared.datetime.year + years)
        expect(datetime.month) |> to(eq shared.datetime.month)
      end
    end

    describe "days" do
      before do
        {:shared, datetime: %DateTime{Momento.date | month: 6, day: 15}}
      end

      it "should add nothing" do
        days = 0
        datetime = Momento.add(shared.datetime, days, :days)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add days without rollover" do
        days = 10
        datetime = Momento.add(shared.datetime, days, :days)

        expect(datetime.day) |> to(eq shared.datetime.day + days)
        expect(datetime.month) |> to(eq shared.datetime.month)
      end

      it "should add days and rollover months" do
        days = 5 + Momento.Guards.days_in_month(shared.datetime.month) +
          Momento.Guards.days_in_month(shared.datetime.month + 1) +
          Momento.Guards.days_in_month(shared.datetime.month + 2)
          datetime = Momento.add(shared.datetime, days, :days)

          expect(datetime.day) |> to(eq shared.datetime.day + 5)
          expect(datetime.month) |> to(eq shared.datetime.month + 3)
      end

      it "should only add months" do
        days = Momento.Guards.days_in_month(shared.datetime.month) +
          Momento.Guards.days_in_month(shared.datetime.month + 1) +
          Momento.Guards.days_in_month(shared.datetime.month + 2)
        datetime = Momento.add(shared.datetime, days, :days)

        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month + 3)
      end
    end

    describe "hours" do
      before do
        {:shared, datetime: %DateTime{Momento.date | day: 15, hour: 12}}
      end

      it "should add nothing" do
        hours = 0
        datetime = Momento.add(shared.datetime, hours, :hours)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add hours without rollover" do
        hours = 5
        datetime = Momento.add(shared.datetime, hours, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour + hours)
        expect(datetime.day) |> to(eq shared.datetime.day)
      end

      it "should add hours and rollover days" do
        hours = 52
        datetime = Momento.add(shared.datetime, hours, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour + 4)
        expect(datetime.day) |> to(eq shared.datetime.day + 2)
      end

      it "should only add days" do
        hours = 48
        datetime = Momento.add(shared.datetime, hours, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day + 2)
      end
    end

    describe "minutes" do
      before do
        {:shared, datetime: %DateTime{Momento.date | hour: 12, minute: 15}}
      end

      it "should add nothing" do
        minutes = 0
        datetime = Momento.add(shared.datetime, minutes, :minutes)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add minutes without rollover" do
        minutes = 30
        datetime = Momento.add(shared.datetime, minutes, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute + minutes)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
      end

      it "should add minutes and rollover hours" do
        minutes = 150
        datetime = Momento.add(shared.datetime, minutes, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute + 30)
        expect(datetime.hour) |> to(eq shared.datetime.hour + 2)
      end

      it "should only add hours" do
        minutes = 120
        datetime = Momento.add(shared.datetime, minutes, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute)
        expect(datetime.hour) |> to(eq shared.datetime.hour + 2)
      end
    end

    describe "seconds" do
      before do
        {:shared, datetime: %DateTime{Momento.date | minute: 15, second: 15}}
      end

      it "should add nothing" do
        seconds = 0
        datetime = Momento.add(shared.datetime, seconds, :seconds)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add seconds without rollover" do
        seconds = 30
        datetime = Momento.add(shared.datetime, seconds, :seconds)

        expect(datetime.second) |> to(eq shared.datetime.second + seconds)
        expect(datetime.minute) |> to(eq shared.datetime.minute)
      end

      it "should add seconds and rollover minutes" do
        seconds = 150
        datetime = Momento.add(shared.datetime, seconds, :seconds)

        expect(datetime.second) |> to(eq shared.datetime.second + 30)
        expect(datetime.minute) |> to(eq shared.datetime.minute + 2)
      end

      it "should add only minutes" do
        seconds = 120
        datetime = Momento.add(shared.datetime, seconds, :seconds)

        expect(datetime.second) |> to(eq shared.datetime.second)
        expect(datetime.minute) |> to(eq shared.datetime.minute + 2)
      end
    end
  end
end
