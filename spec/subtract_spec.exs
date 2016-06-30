defmodule SubtractSpec do
  require Momento
  require Momento.Guards
  use ESpec

  describe "subtract" do
    describe "years" do
      before do
        {:shared, datetime: %DateTime{Momento.date | year: 2016}}
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
        {:shared, datetime: %DateTime{Momento.date | month: 6}}
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
        {:shared, datetime: %DateTime{Momento.date | month: 6, day: 15}}
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
        days = 5 + Momento.Guards.days_in_month(shared.datetime.month - 1) +
          Momento.Guards.days_in_month(shared.datetime.month - 2) +
          Momento.Guards.days_in_month(shared.datetime.month - 3)
          datetime = Momento.subtract(shared.datetime, days, :days)

          expect(datetime.day) |> to(eq shared.datetime.day - 5)
          expect(datetime.month) |> to(eq shared.datetime.month - 3)
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
  end
end
