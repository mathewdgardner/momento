defmodule SubtractSpec do
  require Momento
  require Momento.Guards
  use ESpec

  describe "subtract" do
    describe "years" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | year: 2016}}
      end

      it "should map singular to plural" do
        years = 1
        datetime = Momento.subtract(shared.datetime, years, :year)

        expect(datetime.year) |> to(eq shared.datetime.year - years)
      end

      it "should subtract nothing" do
        num = 0
        datetime = Momento.subtract(shared.datetime, num, :years)

        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should subtract some years" do
        num = 5
        datetime = Momento.subtract(shared.datetime, num, :years)

        expect(datetime.year) |> to(eq shared.datetime.year - num)
      end
    end

    describe "months" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | month: 6}}
      end

      it "should map singular to plural" do
        months = 1
        datetime = Momento.subtract(shared.datetime, months, :month)

        expect(datetime.month) |> to(eq shared.datetime.month - months)
      end

      it "should subtract nothing" do
        months = 0
        datetime = Momento.subtract(shared.datetime, months, :months)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should subtract months without rollover" do
        months = 3
        datetime = Momento.subtract(shared.datetime, months, :months)

        expect(datetime.year) |> to(eq shared.datetime.year)
        expect(datetime.month) |> to(eq shared.datetime.month - months)
      end

      it "should subtract months and rollover years" do
        months = 19
        datetime = Momento.subtract(shared.datetime, months, :months)

        expect(datetime.year) |> to(eq shared.datetime.year - 2)
        expect(datetime.month) |> to(eq 11)
      end

      it "should only subtract years" do
        months = 24
        years = 24 / 12
        datetime = Momento.subtract(shared.datetime, months, :months)

        expect(datetime.year) |> to(eq shared.datetime.year - years)
        expect(datetime.month) |> to(eq shared.datetime.month)
      end
    end

    describe "days" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | month: 6, day: 15}}
      end

      it "should map singular to plural" do
        days = 1
        datetime = Momento.subtract(shared.datetime, days, :day)

        expect(datetime.day) |> to(eq shared.datetime.day - days)
      end

      it "should subtract nothing" do
        days = 0
        datetime = Momento.subtract(shared.datetime, days, :days)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should subtract days without rollover" do
        days = 10
        datetime = Momento.subtract(shared.datetime, days, :days)

        expect(datetime.day) |> to(eq shared.datetime.day - days)
        expect(datetime.month) |> to(eq shared.datetime.month)
      end

      it "should subtract days and rollover months" do
        days = 21
        datetime = Momento.subtract(shared.datetime, days, :days)

          expect(datetime.day) |> to(eq shared.datetime.day + 10)
          expect(datetime.month) |> to(eq shared.datetime.month - 1)
      end

      it "should only subtract months" do
        days = Momento.Guards.days_in_month(shared.datetime.month - 1) +
          Momento.Guards.days_in_month(shared.datetime.month - 2) +
          Momento.Guards.days_in_month(shared.datetime.month - 3)
        datetime = Momento.subtract(shared.datetime, days, :days)

        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month - 3)
      end
    end

    describe "hours" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | day: 15, hour: 9}}
      end

      it "should map singular to plural" do
        hours = 1
        datetime = Momento.subtract(shared.datetime, hours, :hour)

        expect(datetime.hour) |> to(eq shared.datetime.hour - hours)
      end

      it "should subtract nothing" do
        hours = 0
        datetime = Momento.subtract(shared.datetime, hours, :hours)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should subtract hours without rollover" do
        hours = 5
        datetime = Momento.subtract(shared.datetime, hours, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour - hours)
        expect(datetime.day) |> to(eq shared.datetime.day)
      end

      it "should subtract hours and rollover days" do
        hours = 15
        datetime = Momento.subtract(shared.datetime, hours, :hours)

        expect(datetime.hour) |> to(eq 18)
        expect(datetime.day) |> to(eq shared.datetime.day - 1)
      end

      it "should only subtract days" do
        hours = 48
        datetime = Momento.subtract(shared.datetime, hours, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day - 2)
      end
    end

    describe "minutes" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | hour: 12, minute: 15}}
      end

      it "should map singular to plural" do
        minutes = 1
        datetime = Momento.subtract(shared.datetime, minutes, :minute)

        expect(datetime.minute) |> to(eq shared.datetime.minute - minutes)
      end

      it "should subtract nothing" do
        minutes = 0
        datetime = Momento.subtract(shared.datetime, minutes, :minutes)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should subtract minutes without rollover" do
        minutes = 10
        datetime = Momento.subtract(shared.datetime, minutes, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute - minutes)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
      end

      it "should subtract minutes and rollover hours" do
        minutes = 150
        datetime = Momento.subtract(shared.datetime, minutes, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute + 30)
        expect(datetime.hour) |> to(eq shared.datetime.hour - 3)
      end

      it "should only subtract hours" do
        minutes = 120
        datetime = Momento.subtract(shared.datetime, minutes, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute)
        expect(datetime.hour) |> to(eq shared.datetime.hour - 2)
      end
    end

    describe "seconds" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | minute: 15, second: 15}}
      end

      it "should map singular to plural" do
        seconds = 1
        datetime = Momento.subtract(shared.datetime, seconds, :second)

        expect(datetime.second) |> to(eq shared.datetime.second - seconds)
      end

      it "should subtract nothing" do
        seconds = 0
        datetime = Momento.subtract(shared.datetime, seconds, :seconds)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should subtract seconds without rollover" do
        seconds = 10
        datetime = Momento.subtract(shared.datetime, seconds, :seconds)

        expect(datetime.second) |> to(eq shared.datetime.second - seconds)
        expect(datetime.minute) |> to(eq shared.datetime.minute)
      end

      it "should subtract seconds and rollover minutes" do
        seconds = 150
        datetime = Momento.subtract(shared.datetime, seconds, :seconds)

        expect(datetime.second) |> to(eq shared.datetime.second + 30)
        expect(datetime.minute) |> to(eq shared.datetime.minute - 3)
      end

      it "should subtract only minutes" do
        seconds = 120
        datetime = Momento.subtract(shared.datetime, seconds, :seconds)

        expect(datetime.second) |> to(eq shared.datetime.second)
        expect(datetime.minute) |> to(eq shared.datetime.minute - 2)
      end
    end

    describe "microseconds" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | second: 15, microsecond: {123456, 6}}}
      end

      it "should map singular to plural" do
        microseconds = 0
        datetime = Momento.subtract(shared.datetime, microseconds, :microsecond)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should subtract nothing" do
        microseconds = 0
        datetime = Momento.subtract(shared.datetime, microseconds, :microseconds)

        expect(datetime) |> to(eq shared.datetime)
      end

      it "should subtract microseconds without rollover" do
        microseconds = 111
        datetime = Momento.subtract(shared.datetime, microseconds, :microseconds)
        {oldMicrosecond, oldPrecision} = shared.datetime.microsecond
        {newMicrosecond, newPrecision} = datetime.microsecond

        expect(newMicrosecond) |> to(eq oldMicrosecond - microseconds)
        expect(newPrecision) |> to(eq oldPrecision)
      end

      it "should subtract microseconds and rollover seconds" do
        microseconds = 123458
        datetime = Momento.subtract(shared.datetime, microseconds, :microseconds)
        {_, oldPrecision} = shared.datetime.microsecond
        {newMicrosecond, newPrecision} = datetime.microsecond

        expect(newMicrosecond) |> to(eq 999998)
        expect(newPrecision) |> to(eq oldPrecision)
        expect(datetime.second) |> to(eq shared.datetime.second - 1)
      end

      it "should only subtract seconds" do
        microseconds = 2000000
        datetime = Momento.subtract(shared.datetime, microseconds, :microseconds)
        {oldMicrosecond, oldPrecision} = shared.datetime.microsecond
        {newMicrosecond, newPrecision} = datetime.microsecond

        expect(newMicrosecond) |> to(eq oldMicrosecond)
        expect(newPrecision) |> to(eq oldPrecision)
        expect(datetime.second) |> to(eq shared.datetime.second - 2)
      end
    end
  end
end
