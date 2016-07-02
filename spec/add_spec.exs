defmodule AddSpec do
  require Momento
  require Momento.Guards
  use ESpec

  describe "add" do
    describe "years" do
      before do
        {:shared, datetime: %DateTime{Momento.date | year: 2016}}
      end

      it "should map singular to plural" do
        years = 1
        datetime = Momento.add(shared.datetime, years, :year)

        expect(datetime.year) |> to(eq shared.datetime.year + years)
      end

      it "should add nothing" do
        years = 0
        datetime = Momento.add(shared.datetime, years, :years)

        expect(datetime.year) |> to(eq shared.datetime.year + years)
      end

      it "should add some years" do
        years = 5
        datetime = Momento.add(shared.datetime, years, :years)

        expect(datetime.year) |> to(eq shared.datetime.year + years)
      end
    end

    describe "months" do
      before do
        {:shared, datetime: %DateTime{Momento.date | month: 6}}
      end

      it "should map singular to plural" do
        months = 1
        datetime = Momento.add(shared.datetime, months, :month)

        expect(datetime.month) |> to(eq shared.datetime.month + months)
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

      it "should map singular to plural" do
        days = 1
        datetime = Momento.add(shared.datetime, days, :day)

        expect(datetime.day) |> to(eq shared.datetime.day + days)
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
        days = 21
        datetime = Momento.add(shared.datetime, days, :days)

          expect(datetime.day) |> to(eq 6)
          expect(datetime.month) |> to(eq shared.datetime.month + 1)
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

      it "should map singular to plural" do
        hours = 1
        datetime = Momento.add(shared.datetime, hours, :hour)

        expect(datetime.hour) |> to(eq shared.datetime.hour + hours)
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
        hours = 15
        datetime = Momento.add(shared.datetime, hours, :hours)

        expect(datetime.hour) |> to(eq 3)
        expect(datetime.day) |> to(eq shared.datetime.day + 1)
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

      it "should map singular to plural" do
        minutes = 1
        datetime = Momento.add(shared.datetime, minutes, :minute)

        expect(datetime.minute) |> to(eq shared.datetime.minute + minutes)
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
        minutes = 50
        datetime = Momento.add(shared.datetime, minutes, :minutes)

        expect(datetime.minute) |> to(eq 4)
        expect(datetime.hour) |> to(eq shared.datetime.hour + 1)
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

      it "should map singular to plural" do
        seconds = 1
        datetime = Momento.add(shared.datetime, seconds, :second)

        expect(datetime.second) |> to(eq shared.datetime.second + seconds)
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
        seconds = 50
        datetime = Momento.add(shared.datetime, seconds, :seconds)

        expect(datetime.second) |> to(eq 4)
        expect(datetime.minute) |> to(eq shared.datetime.minute + 1)
      end

      it "should add only minutes" do
        seconds = 120
        datetime = Momento.add(shared.datetime, seconds, :seconds)

        expect(datetime.second) |> to(eq shared.datetime.second)
        expect(datetime.minute) |> to(eq shared.datetime.minute + 2)
      end
    end

    describe "milliseconds" do
      before do
        {:shared, datetime: %DateTime{Momento.date | second: 15, microsecond: {123456, 6}}}
      end

      it "should map singular to plural" do
        milliseconds = 0
        datetime = Momento.add(shared.datetime, milliseconds, :millisecond)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add nothing" do
        milliseconds = 0
        datetime = Momento.add(shared.datetime, milliseconds, :milliseconds)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add milliseconds without rollover" do
        milliseconds = 100
        datetime = Momento.add(shared.datetime, milliseconds, :milliseconds)
        {oldMicrosecond, oldPrecision} = shared.datetime.microsecond
        {newMicrosecond, newPrecision} = datetime.microsecond

        expect(newMicrosecond) |> to(eq oldMicrosecond + milliseconds * 1000)
        expect(newPrecision) |> to(eq oldPrecision)
        expect(datetime.second) |> to(eq shared.datetime.second)
      end

      it "should add milliseconds and rollover seconds" do
        milliseconds = 2111
        datetime = Momento.add(shared.datetime, milliseconds, :milliseconds)
        {oldMicrosecond, oldPrecision} = shared.datetime.microsecond
        {newMicrosecond, newPrecision} = datetime.microsecond

        expect(newMicrosecond) |> to(eq oldMicrosecond + 111000)
        expect(newPrecision) |> to(eq oldPrecision)
        expect(datetime.second) |> to(eq shared.datetime.second + 2)
      end

      it "should only add seconds" do
        milliseconds = 2000
        datetime = Momento.add(shared.datetime, milliseconds, :milliseconds)

        expect(datetime.microsecond) |> to(eq shared.datetime.microsecond)
        expect(datetime.second) |> to(eq shared.datetime.second + 2)
      end
    end

    describe "microseconds" do
      before do
        {:shared, datetime: %DateTime{Momento.date | microsecond: {123456, 6}}}
      end

      it "should map singular to plural" do
        microseconds = 0
        datetime = Momento.add(shared.datetime, microseconds, :microsecond)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add nothing" do
        microseconds = 0
        datetime = Momento.add(shared.datetime, microseconds, :microseconds)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should add microseconds without rollover" do
        microseconds = 111
        datetime = Momento.add(shared.datetime, microseconds, :microseconds)
        {oldMicrosecond, oldPrecision} = shared.datetime.microsecond
        {newMicrosecond, newPrecision} = datetime.microsecond

        expect(newMicrosecond) |> to(eq oldMicrosecond + microseconds)
        expect(newPrecision) |> to(eq oldPrecision)
      end

      it "should add microseconds and rollover seconds" do
        microseconds = 2111111
        datetime = Momento.add(shared.datetime, microseconds, :microseconds)
        {oldMicrosecond, oldPrecision} = shared.datetime.microsecond
        {newMicrosecond, newPrecision} = datetime.microsecond

        expect(newMicrosecond) |> to(eq oldMicrosecond + 111111)
        expect(newPrecision) |> to(eq oldPrecision)
      end

      it "should only add seconds" do
        microseconds = 2000000
        datetime = Momento.add(shared.datetime, microseconds, :microseconds)
        {oldMicrosecond, oldPrecision} = shared.datetime.microsecond
        {newMicrosecond, newPrecision} = datetime.microsecond

        expect(newMicrosecond) |> to(eq oldMicrosecond)
        expect(newPrecision) |> to(eq oldPrecision)
        expect(datetime.second) |> to(eq shared.datetime.second + 2)
      end
    end
  end
end
