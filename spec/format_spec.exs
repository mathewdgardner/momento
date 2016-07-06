defmodule FormatSpec do
  require Momento
  use ESpec

  describe "format" do
    describe "years" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | year: 2016}}
      end

      it "should replace the YYYY token with a four digit year" do
        shared.datetime |> Momento.format("YYYY") |> expect |> to(eql "2016")
      end

      it "should replace the YY token with with a two digit year padded with a zero" do
        shared.datetime |> Momento.format("YY") |> expect |> to(eql "16")
      end

      it "should replace the Y token with with a year value larger than 9999"
    end

    describe "months" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | month: 5}}
      end

      it "should replace the MMMM token with the full month name"
      it "should replace the MMM token with the month abbreviation"

      it "should replace the MM token with two digit month of year padded with a zero" do
        shared.datetime |> Momento.format("MM") |> expect |> to(eql "05")
      end

      it "should replace the Mo token with month of year ordinal"

      it "should replace the M token with month of year without zero padding" do
        shared.datetime |> Momento.format("M") |> expect |> to(eql "5")
      end
    end

    describe "days" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | day: 5}}
      end

      it "should replace the DDDD token with three digit day of year padded with two zeros"
      it "should replace the DDDo token with day of year ordinal"
      it "should replace the DDD token with day of year without zero padding"

      it "should replace the DD token with day of month padded with a zero" do
        shared.datetime |> Momento.format("DD") |> expect |> to(eql "05")
      end

      it "should replace the Do token with day of month ordinal"

      it "should replace the D token with day of month without zero padding" do
        shared.datetime |> Momento.format("D") |> expect |> to(eql "5")
      end

      it "should replace the dddd token with day of week full name"
      it "should replace the ddd token with day of week three letter abbreviation"
      it "should replace the dd token with day of week two letter abbreviation"
      it "should replace the do token with day of week ordinal zero indexed"
      it "should replace the d token with day of week zero indexed"
    end

    describe "hours" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | hour: 5}}
      end

      it "should replace the HH token with two digit hour of day padded with a zero" do
        shared.datetime |> Momento.format("HH") |> expect |> to(eql "05")
      end

      it "should replace the H token with hour of day without zero padding" do
        shared.datetime |> Momento.format("H") |> expect |> to(eql "5")
      end

      it "should replace the hh token with hour of day in 12 hour format padded with a zero"
      it "should replace the h token with hour of day in 12 hour format without zero padding"
      it "should replace the kk token with hour of day in 24 hour format padded with a zero"
      it "should replace the k token with hour of day in 24 hour format without zero padding"
    end

    describe "minutes" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | minute: 5}}
      end

      it "should replace the mm token with two digit minute of hour padded with a zero" do
        shared.datetime |> Momento.format("mm") |> expect |> to(eql "05")
      end

      it "should replace the m token with minute of hour without zero padding" do
        shared.datetime |> Momento.format("m") |> expect |> to(eql "5")
      end
    end

    describe "seconds" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | second: 5}}
      end

      it "should replace the mm token with two digit second of minute padded with a zero" do
        shared.datetime |> Momento.format("ss") |> expect |> to(eql "05")
      end

      it "should replace the m token with second of minute without zero padding" do
        shared.datetime |> Momento.format("s") |> expect |> to(eql "5")
      end
    end

    describe "fractional seconds" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | microsecond: {123456, 6}}}
      end

      it "should replace the SSSS-SSSSSSSSS token with "
      it "should replace the SSS token with three digit milliseconds with zero padding"
      it "should replace the SS token with two digit centisecond with zero padding"
      it "should replace the S token with one digit decisecond"
    end

    describe "time zone" do
      it "should replace the ZZ token with +/- four digit time offset with zero padding"
      it "should replace the Z token with +/- four digit time offset with zero padding and colon"
    end

    describe "am / pm" do
      it "should replace the A token with AM"
      it "should replace the A token with PM"
      it "should replace the a token with am"
      it "should replace the a token with pm"
    end

    describe "quarter" do
      it "should replace the Q token with quarter of year non-zero indexed"
      it "should replace the Qo token with quarter of year non-zero indexed ordinal"
    end

    describe "day of week" do
      it "should replace the E token with integer day of week non-zero indexed"
      it "should replace the e token with integer day of week zero indexed"
    end

    describe "week of year" do
      it "should replace the WW token with the week of year with padded with a zero"
      it "should replace the Wo token with the week of year ordinal"
      it "should replace the W token with the week of year without zero padding"
      it "should replace the ww token with the week of year with padded with a zero"
      it "should replace the wo token with the week of year ordinal"
      it "should replace the w token with the week of year without zero padding"
    end

    describe "week year" do
      it "should replace the GGGG token with four digit week year"
      it "should replace the GG token with two digit week year"
      it "should replace the gggg token with four digit week year"
      it "should replace the gg token with two digit week year"
    end

    describe "unix epoch" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | year: 2016, month: 7, day: 1, hour: 12, minute: 0, second: 5, microsecond: {0, 6}}}
      end

      it "should replace the X token with unix time in seconds" do
        shared.datetime |> Momento.format("X") |> expect |> to(eql "1467374405")
      end

      it "should replace the x token with unix time in seconds" do
        shared.datetime |> Momento.format("x") |> expect |> to(eql "1467374405000")
      end
    end

    describe "localized formats" do
      it "should replace the LLLL token with full month, day of month, day of week, year and 12 hour formatted time"
      it "should replace the LLL token with full month, day of month, year and 12 hour formatted time"
      it "should replace the LL token with full month, day of month and year"
      it "should replace the LTS token with 12 hour formatted time with seconds"
      it "should replace the LT token with 12 hour formatted time"
      it "should replace the L token with month numeral, day of month, year"
      it "should replace the llll token with abbreviated month, day of month, day of week, year and 12 hour formatted time"
      it "should replace the lll token with abbreviated month, day of month, year and 12 hour formatted time"
      it "should replace the ll token with abbreviated month, day of month and year"
      it "should replace the l token with abbreviated numeral, day of month, year"
    end
  end
end
