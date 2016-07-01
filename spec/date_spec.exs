defmodule DateSpec do
  require Momento
  require Momento.Guards
  use ESpec

  describe "date" do
    describe "unix" do
      it "should return a DateTime struct from a unix timestamp in seconds" do
        {:ok, datetime} = Momento.date(1467316077)
        expect datetime |> to(be_struct DateTime)
      end

      it "should return a DateTime struct from a unix timestamp in millisconds" do
        {:ok, datetime} = Momento.date(1467316261999)
        expect datetime |> to(be_struct DateTime)
      end

      it "should return a DateTime struct from a unix timestamp in microsconds" do
        {:ok, datetime} = Momento.date(1467316272333763)
        expect datetime |> to(be_struct DateTime)
      end

      it "should return a DateTime struct from a unix timestamp in nanosconds" do
        {:ok, datetime} = Momento.date(1467316281921158374)
        expect datetime |> to(be_struct DateTime)
      end
    end

    describe "ISO8601" do
      it "should return a DateTime struct from a ISO8601 string" do
        datetime = Momento.date("2016-04-20T15:05:13.991Z")

        expect(datetime.year) |> to(eql 2016)
        expect(datetime.month) |> to(eql 4)
        expect(datetime.day) |> to(eql 20)
        expect(datetime.hour) |> to(eql 15)
        expect(datetime.minute) |> to(eql 5)
        expect(datetime.second) |> to(eql 13)
        expect(datetime.microsecond) |> to(eql {991000, 6})
      end
    end

    describe "ISO date" do
      it "should return a DateTime struct from a ISO date string" do
        datetime = Momento.date("2016-04-20")

        expect(datetime.year) |> to(eql 2016)
        expect(datetime.month) |> to(eql 4)
        expect(datetime.day) |> to(eql 20)
      end
    end
  end

  describe "date!" do
    it "should return value" do
      expect(Momento.date!(1467316077)) |> to(be_struct DateTime)
    end
  end
end
