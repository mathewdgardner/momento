defmodule AddSpec do
  require Momento
  require Momento.Guards
  use ESpec

  describe "add" do
    describe "years" do
      before do
        {:shared, datetime: %DateTime{Momento.date | year: 2016}}
      end

      it "should add some years" do
        num = 5
        datetime = Momento.add(shared.datetime, num, :years)

        expect(datetime.year) |> to(eq shared.datetime.year + num)
      end

      it "should add no years" do
        num = 0
        datetime = Momento.add(shared.datetime, num, :years)

        expect(datetime.year) |> to(eq shared.datetime.year + num)
      end
    end

    describe "months" do
      before do
        {:shared, datetime: %DateTime{Momento.date | month: 6}}
      end

      it "should add months and no years" do
        num = 6
        datetime = Momento.add(shared.datetime, num, :months)

        expect(datetime.year) |> to(eq shared.datetime.year)
        expect(datetime.month) |> to(eq shared.datetime.month + num)
      end

      it "should add months and only one year" do
        num = 7
        datetime = Momento.add(shared.datetime, num, :months)

        expect(datetime.year) |> to(eq shared.datetime.year + 1)
        expect(datetime.month) |> to(eq 1)
      end

      it "should add years and no months" do
        num = 24
        years = 24 / 12
        datetime = Momento.add(shared.datetime, num, :months)

        expect(datetime.year) |> to(eq shared.datetime.year + years)
        expect(datetime.month) |> to(eq shared.datetime.month)
      end

      it "should add months and many years" do
        num = 100
        years = Float.floor(100 / 12) |> round
        months = rem(num, 12)
        datetime = Momento.add(shared.datetime, num, :months)

        expect(datetime.year) |> to(eq shared.datetime.year + years)
        expect(datetime.month) |> to(eq shared.datetime.month + months)
      end
    end

    describe "days" do
      before do
        {:shared, datetime: %DateTime{Momento.date | month: 6, day: 15}}
      end

      it "should add days and no months" do
        num = 10
        datetime = Momento.add(shared.datetime, num, :days)

        expect(datetime.day) |> to(eq shared.datetime.day + num)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add a month and no days" do
        num = Momento.Guards.days_in_month(shared.datetime.month)
        datetime = Momento.add(shared.datetime, num, :days)

        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month + 1)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add days and start next month" do
        num = 16
        datetime = Momento.add(shared.datetime, num, :days)

        expect(datetime.day) |> to(eq 1)
        expect(datetime.month) |> to(eq shared.datetime.month + 1)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many months and no days" do
        num = Momento.Guards.days_in_month(shared.datetime.month) +
          Momento.Guards.days_in_month(shared.datetime.month + 1) +
          Momento.Guards.days_in_month(shared.datetime.month + 2) +
          Momento.Guards.days_in_month(shared.datetime.month + 3)
        datetime = Momento.add(shared.datetime, num, :days)

        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month + 4)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many days and some months" do
        num = Momento.Guards.days_in_month(shared.datetime.month) +
          Momento.Guards.days_in_month(shared.datetime.month + 1) +
          Momento.Guards.days_in_month(shared.datetime.month + 2) +
          Momento.Guards.days_in_month(shared.datetime.month + 3) + 5
        datetime = Momento.add(shared.datetime, num, :days)

        expect(datetime.day) |> to(eq shared.datetime.day + 5)
        expect(datetime.month) |> to(eq shared.datetime.month + 4)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many days and some years" do
        years = 5
        days = 5
        num = 365 * years + days
        datetime = Momento.add(shared.datetime, num, :days)

        expect(datetime.day) |> to(eq shared.datetime.day + days)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year + years)
      end

      it "should add many days, months and years" do
        years = 5
        days = 5
        num = 365 * years + days
        datetime = Momento.add(shared.datetime, num, :days)

        expect(datetime.day) |> to(eq shared.datetime.day + days)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year + years)
      end
    end

    describe "hours" do
      before do
        {:shared, datetime: %DateTime{Momento.date | month: 6, day: 15, hour: 12}}
      end

      it "should add some hours" do
        num = 5
        datetime = Momento.add(shared.datetime, num, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour + num)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many hours and a day" do
        num = 20
        datetime = Momento.add(shared.datetime, num, :hours)

        expect(datetime.hour) |> to(eq 8)
        expect(datetime.day) |> to(eq shared.datetime.day + 1)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many hours and many days" do
        num = 100
        datetime = Momento.add(shared.datetime, num, :hours)

        expect(datetime.hour) |> to(eq 16)
        expect(datetime.day) |> to(eq shared.datetime.day + 4)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many hours and a month" do
        num = 725
        datetime = Momento.add(shared.datetime, num, :hours)

        expect(datetime.hour) |> to(eq 17)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month + 1)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many hours and a year" do
        num = 8765
        datetime = Momento.add(shared.datetime, num, :hours)

        expect(datetime.hour) |> to(eq 17)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year + 1)
      end

      it "should add days and no hours" do
        num = 48
        datetime = Momento.add(shared.datetime, num, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day + 2)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add months and no hours or days" do
        num = 1464
        datetime = Momento.add(shared.datetime, num, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month + 2)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add years and no hours" do
        num = 17520
        datetime = Momento.add(shared.datetime, num, :hours)

        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year + 2)
      end
    end

    describe "minutes" do
      before do
        {:shared, datetime: %DateTime{Momento.date | month: 6, day: 15, hour: 12, minute: 15}}
      end

      it "should add few minutes" do
        num = 30
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute + num)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many minutes and an hour" do
        num = 55
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq 10)
        expect(datetime.hour) |> to(eq shared.datetime.hour + 1)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many minutes and a day" do
        num = 1455
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute + 15)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day + 1)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many minutes and a month" do
        num = 43215
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute + 15)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month + 1)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many minutes and a year" do
        num = 525615
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute + 15)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year + 1)
      end

      it "should add no minutes but add an hour" do
        num = 60
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute)
        expect(datetime.hour) |> to(eq shared.datetime.hour + 1)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add no minutes but add a day" do
        num = 1440
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day + 1)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add no minutes but add a month" do
        num = 43200
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month + 1)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add no minutes but add a year" do
        num = 525600
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq shared.datetime.minute)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year + 1)
      end

      it "should add many minutes and many hours" do
        num = 170
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq 5)
        expect(datetime.hour) |> to(eq shared.datetime.hour + 3)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many minutes and many days" do
        num = 3 * 1440 - 10
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq 5)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day + 3)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many minutes and many months" do
        num = 60 * 24 * 30 + 60 * 24 * 31 - 10
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq 5)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month + 2)
        expect(datetime.year) |> to(eq shared.datetime.year)
      end

      it "should add many minutes and many years" do
        num = 2 * 365 * 24 * 60 - 10
        datetime = Momento.add(shared.datetime, num, :minutes)

        expect(datetime.minute) |> to(eq 5)
        expect(datetime.hour) |> to(eq shared.datetime.hour)
        expect(datetime.day) |> to(eq shared.datetime.day)
        expect(datetime.month) |> to(eq shared.datetime.month)
        expect(datetime.year) |> to(eq shared.datetime.year + 2)
      end
    end
  end
end
