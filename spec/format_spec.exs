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

      it "should replace the MMMM token with the full month name" do
        %DateTime{Momento.date! | month: 1} |> Momento.format("MMMM") |> expect |> to(eql "January")
        %DateTime{Momento.date! | month: 2} |> Momento.format("MMMM") |> expect |> to(eql "February")
        %DateTime{Momento.date! | month: 3} |> Momento.format("MMMM") |> expect |> to(eql "March")
        %DateTime{Momento.date! | month: 4} |> Momento.format("MMMM") |> expect |> to(eql "April")
        %DateTime{Momento.date! | month: 5} |> Momento.format("MMMM") |> expect |> to(eql "May")
        %DateTime{Momento.date! | month: 6} |> Momento.format("MMMM") |> expect |> to(eql "June")
        %DateTime{Momento.date! | month: 7} |> Momento.format("MMMM") |> expect |> to(eql "July")
        %DateTime{Momento.date! | month: 8} |> Momento.format("MMMM") |> expect |> to(eql "August")
        %DateTime{Momento.date! | month: 9} |> Momento.format("MMMM") |> expect |> to(eql "September")
        %DateTime{Momento.date! | month: 10} |> Momento.format("MMMM") |> expect |> to(eql "October")
        %DateTime{Momento.date! | month: 11} |> Momento.format("MMMM") |> expect |> to(eql "November")
        %DateTime{Momento.date! | month: 12} |> Momento.format("MMMM") |> expect |> to(eql "December")
      end

      it "should replace the MMM token with the month abbreviation" do
        %DateTime{Momento.date! | month: 1} |> Momento.format("MMM") |> expect |> to(eql "Jan")
        %DateTime{Momento.date! | month: 2} |> Momento.format("MMM") |> expect |> to(eql "Feb")
        %DateTime{Momento.date! | month: 3} |> Momento.format("MMM") |> expect |> to(eql "Mar")
        %DateTime{Momento.date! | month: 4} |> Momento.format("MMM") |> expect |> to(eql "Apr")
        %DateTime{Momento.date! | month: 5} |> Momento.format("MMM") |> expect |> to(eql "May")
        %DateTime{Momento.date! | month: 6} |> Momento.format("MMM") |> expect |> to(eql "Jun")
        %DateTime{Momento.date! | month: 7} |> Momento.format("MMM") |> expect |> to(eql "Jul")
        %DateTime{Momento.date! | month: 8} |> Momento.format("MMM") |> expect |> to(eql "Aug")
        %DateTime{Momento.date! | month: 9} |> Momento.format("MMM") |> expect |> to(eql "Sep")
        %DateTime{Momento.date! | month: 10} |> Momento.format("MMM") |> expect |> to(eql "Oct")
        %DateTime{Momento.date! | month: 11} |> Momento.format("MMM") |> expect |> to(eql "Nov")
        %DateTime{Momento.date! | month: 12} |> Momento.format("MMM") |> expect |> to(eql "Dec")        
      end

      it "should replace the MM token with two digit month of year padded with a zero" do
        shared.datetime |> Momento.format("MM") |> expect |> to(eql "05")
      end

      it "should replace the Mo token with month of year ordinal" do
        %DateTime{Momento.date! | month: 1} |> Momento.format("Mo") |> expect |> to(eql "1st")
        %DateTime{Momento.date! | month: 2} |> Momento.format("Mo") |> expect |> to(eql "2nd")
        %DateTime{Momento.date! | month: 3} |> Momento.format("Mo") |> expect |> to(eql "3rd")
        %DateTime{Momento.date! | month: 4} |> Momento.format("Mo") |> expect |> to(eql "4th")
        %DateTime{Momento.date! | month: 5} |> Momento.format("Mo") |> expect |> to(eql "5th")
        %DateTime{Momento.date! | month: 6} |> Momento.format("Mo") |> expect |> to(eql "6th")
        %DateTime{Momento.date! | month: 7} |> Momento.format("Mo") |> expect |> to(eql "7th")
        %DateTime{Momento.date! | month: 8} |> Momento.format("Mo") |> expect |> to(eql "8th")
        %DateTime{Momento.date! | month: 9} |> Momento.format("Mo") |> expect |> to(eql "9th")
        %DateTime{Momento.date! | month: 10} |> Momento.format("Mo") |> expect |> to(eql "10th")
        %DateTime{Momento.date! | month: 11} |> Momento.format("Mo") |> expect |> to(eql "11th")
        %DateTime{Momento.date! | month: 12} |> Momento.format("Mo") |> expect |> to(eql "12th")  
      end

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

      it "should replace the Do token with day of month ordinal" do
        shared.datetime |> Momento.format("Do") |> expect |> to(eql "5th")
        %DateTime{Momento.date! | day: 1} |> Momento.format("Do") |> expect |> to(eql "1st")
        %DateTime{Momento.date! | day: 2} |> Momento.format("Do") |> expect |> to(eql "2nd")
        %DateTime{Momento.date! | day: 3} |> Momento.format("Do") |> expect |> to(eql "3rd")
        %DateTime{Momento.date! | day: 12} |> Momento.format("Do") |> expect |> to(eql "12th")
        %DateTime{Momento.date! | day: 31} |> Momento.format("Do") |> expect |> to(eql "31st")
      end

      it "should replace the D token with day of month without zero padding" do
        shared.datetime |> Momento.format("D") |> expect |> to(eql "5")
      end
    end

    describe "day of the week" do 
      before do: {:shared, sunday: %DateTime{Momento.date! | day: 29, month: 2, year: 2004}}
      before do: {:shared, monday: %DateTime{Momento.date! | day: 22, month: 3, year: 1993}}
      before do: {:shared, tuesday: %DateTime{Momento.date! | day: 5,  month: 12, year: 2023}}
      before do: {:shared, wednesday: %DateTime{Momento.date! | day: 20, month: 8, year: 2003}}
      before do: {:shared, thursday: %DateTime{Momento.date! | day: 25, month: 1, year: 1996}}
      before do: {:shared, friday: %DateTime{Momento.date! | day: 22, month: 4, year: 2016}}
      before do: {:shared, saturday: %DateTime{Momento.date! | day: 9, month: 6, year: 2007}}

      it "should replace the dddd token with day of week full name" do
        shared.sunday |> Momento.format("dddd") |> expect |> to(eql "Sunday")
        shared.monday |> Momento.format("dddd") |> expect |> to(eql "Monday")
        shared.tuesday |> Momento.format("dddd") |> expect |> to(eql "Tuesday")
        shared.wednesday |> Momento.format("dddd") |> expect |> to(eql "Wednesday")
        shared.thursday |> Momento.format("dddd") |> expect |> to(eql "Thursday")
        shared.friday |> Momento.format("dddd") |> expect |> to(eql "Friday")
        shared.saturday |> Momento.format("dddd") |> expect |> to(eql "Saturday")         
      end

      it "should replace the ddd token with day of week three letter abbreviation" do
        shared.sunday |> Momento.format("ddd") |> expect |> to(eql "Sun")
        shared.monday |> Momento.format("ddd") |> expect |> to(eql "Mon")
        shared.tuesday |> Momento.format("ddd") |> expect |> to(eql "Tue")
        shared.wednesday |> Momento.format("ddd") |> expect |> to(eql "Wed")
        shared.thursday |> Momento.format("ddd") |> expect |> to(eql "Thu")
        shared.friday |> Momento.format("ddd") |> expect |> to(eql "Fri")
        shared.saturday |> Momento.format("ddd") |> expect |> to(eql "Sat")         
      end


      it "should replace the dd token with day of week two letter abbreviation" do
        shared.sunday |> Momento.format("dd") |> expect |> to(eql "Su")
        shared.monday |> Momento.format("dd") |> expect |> to(eql "Mo")
        shared.tuesday |> Momento.format("dd") |> expect |> to(eql "Tu")
        shared.wednesday |> Momento.format("dd") |> expect |> to(eql "We")
        shared.thursday |> Momento.format("dd") |> expect |> to(eql "Th")
        shared.friday |> Momento.format("dd") |> expect |> to(eql "Fr")
        shared.saturday |> Momento.format("dd") |> expect |> to(eql "Sa")        
      end

      it "should replace the do token with day of week ordinal zero indexed in ordinal form" do
        shared.sunday |> Momento.format("do") |> expect |> to(eql "0th")
        shared.monday |> Momento.format("do") |> expect |> to(eql "1st")
        shared.tuesday |> Momento.format("do") |> expect |> to(eql "2nd")
        shared.wednesday |> Momento.format("do") |> expect |> to(eql "3rd")
        shared.thursday |> Momento.format("do") |> expect |> to(eql "4th")
        shared.friday |> Momento.format("do") |> expect |> to(eql "5th")
        shared.saturday |> Momento.format("do") |> expect |> to(eql "6th")
      end

      it "should replace the d token with day of week zero indexed" do
        shared.sunday |> Momento.format("d") |> expect |> to(eql "0")
        shared.monday |> Momento.format("d") |> expect |> to(eql "1")
        shared.tuesday |> Momento.format("d") |> expect |> to(eql "2")
        shared.wednesday |> Momento.format("d") |> expect |> to(eql "3")
        shared.thursday |> Momento.format("d") |> expect |> to(eql "4")
        shared.friday |> Momento.format("d") |> expect |> to(eql "5")
        shared.saturday |> Momento.format("d") |> expect |> to(eql "6")
      end
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

      it "should replace the hh token with hour of day in 12 hour format padded with a zero" do
        %DateTime{Momento.date! | hour: 0} |> Momento.format("hh") |> expect |> to(eql "12")
        %DateTime{Momento.date! | hour: 1} |> Momento.format("hh") |> expect |> to(eql "01")
        %DateTime{Momento.date! | hour: 4} |> Momento.format("hh") |> expect |> to(eql "04")
        %DateTime{Momento.date! | hour: 8} |> Momento.format("hh") |> expect |> to(eql "08")
        %DateTime{Momento.date! | hour: 11} |> Momento.format("hh") |> expect |> to(eql "11")
        %DateTime{Momento.date! | hour: 12} |> Momento.format("hh") |> expect |> to(eql "12")
        %DateTime{Momento.date! | hour: 13} |> Momento.format("hh") |> expect |> to(eql "01")
        %DateTime{Momento.date! | hour: 14} |> Momento.format("hh") |> expect |> to(eql "02")
        %DateTime{Momento.date! | hour: 18} |> Momento.format("hh") |> expect |> to(eql "06")
        %DateTime{Momento.date! | hour: 21} |> Momento.format("hh") |> expect |> to(eql "09")
        %DateTime{Momento.date! | hour: 23} |> Momento.format("hh") |> expect |> to(eql "11")
        %DateTime{Momento.date! | hour: 24} |> Momento.format("hh") |> expect |> to(eql "12")
      end

      it "should replace the h token with hour of day in 12 hour format without zero padding" do
        %DateTime{Momento.date! | hour: 0} |> Momento.format("h") |> expect |> to(eql "12")
        %DateTime{Momento.date! | hour: 1} |> Momento.format("h") |> expect |> to(eql "1")
        %DateTime{Momento.date! | hour: 3} |> Momento.format("h") |> expect |> to(eql "3")
        %DateTime{Momento.date! | hour: 7} |> Momento.format("h") |> expect |> to(eql "7")
        %DateTime{Momento.date! | hour: 11} |> Momento.format("h") |> expect |> to(eql "11")
        %DateTime{Momento.date! | hour: 12} |> Momento.format("h") |> expect |> to(eql "12")
        %DateTime{Momento.date! | hour: 13} |> Momento.format("h") |> expect |> to(eql "1")
        %DateTime{Momento.date! | hour: 15} |> Momento.format("h") |> expect |> to(eql "3")
        %DateTime{Momento.date! | hour: 19} |> Momento.format("h") |> expect |> to(eql "7")
        %DateTime{Momento.date! | hour: 22} |> Momento.format("h") |> expect |> to(eql "10")
        %DateTime{Momento.date! | hour: 23} |> Momento.format("h") |> expect |> to(eql "11")
        %DateTime{Momento.date! | hour: 24} |> Momento.format("h") |> expect |> to(eql "12")
      end

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
      
      it "should replace the A token with AM/PM" do
        %DateTime{Momento.date! | hour: 0} |> Momento.format("A") |> expect |> to(eql "AM")
        %DateTime{Momento.date! | hour: 6} |> Momento.format("A") |> expect |> to(eql "AM")
        %DateTime{Momento.date! | hour: 11} |> Momento.format("A") |> expect |> to(eql "AM")
        %DateTime{Momento.date! | hour: 12} |> Momento.format("A") |> expect |> to(eql "PM")
        %DateTime{Momento.date! | hour: 13} |> Momento.format("A") |> expect |> to(eql "PM")
        %DateTime{Momento.date! | hour: 24} |> Momento.format("A") |> expect |> to(eql "PM")
      end

      it "should replace the a token with am/pm" do
        %DateTime{Momento.date! | hour: 0} |> Momento.format("a") |> expect |> to(eql "am")
        %DateTime{Momento.date! | hour: 6} |> Momento.format("a") |> expect |> to(eql "am")
        %DateTime{Momento.date! | hour: 11} |> Momento.format("a") |> expect |> to(eql "am")
        %DateTime{Momento.date! | hour: 12} |> Momento.format("a") |> expect |> to(eql "pm")
        %DateTime{Momento.date! | hour: 13} |> Momento.format("a") |> expect |> to(eql "pm")
        %DateTime{Momento.date! | hour: 24} |> Momento.format("a") |> expect |> to(eql "pm")
      end
    end

    describe "quarter" do
      before do: {:shared, quarter_one_begin: %DateTime{Momento.date! | month: 1}}
      before do: {:shared, quarter_one_end: %DateTime{Momento.date! | month: 3}}
      before do: {:shared, quarter_two_begin: %DateTime{Momento.date! | month: 4}}
      before do: {:shared, quarter_two_end: %DateTime{Momento.date! | month: 6}}
      before do: {:shared, quarter_three_begin: %DateTime{Momento.date! | month: 7}}
      before do: {:shared, quarter_three_end: %DateTime{Momento.date! | month: 9}}
      before do: {:shared, quarter_four_begin: %DateTime{Momento.date! | month: 10}}
      before do: {:shared, quarter_four_end: %DateTime{Momento.date! | month: 12}}

      it "should replace the Q token with quarter of year non-zero indexed" do
        shared.quarter_one_begin |> Momento.format("Q") |> expect |> to(eql "1")
        shared.quarter_one_end |> Momento.format("Q") |> expect |> to(eql "1")
        shared.quarter_two_begin |> Momento.format("Q") |> expect |> to(eql "2")
        shared.quarter_two_end |> Momento.format("Q") |> expect |> to(eql "2")
        shared.quarter_three_begin |> Momento.format("Q") |> expect |> to(eql "3")
        shared.quarter_three_end |> Momento.format("Q") |> expect |> to(eql "3")
        shared.quarter_four_begin |> Momento.format("Q") |> expect |> to(eql "4")
        shared.quarter_four_end |> Momento.format("Q") |> expect |> to(eql "4")
      end

      it "should replace the Qo token with quarter of year non-zero indexed ordinal" do
        shared.quarter_one_begin |> Momento.format("Qo") |> expect |> to(eql "1st")
        shared.quarter_one_end |> Momento.format("Qo") |> expect |> to(eql "1st")
        shared.quarter_two_begin |> Momento.format("Qo") |> expect |> to(eql "2nd")
        shared.quarter_two_end |> Momento.format("Qo") |> expect |> to(eql "2nd")
        shared.quarter_three_begin |> Momento.format("Qo") |> expect |> to(eql "3rd")
        shared.quarter_three_end |> Momento.format("Qo") |> expect |> to(eql "3rd")
        shared.quarter_four_begin |> Momento.format("Qo") |> expect |> to(eql "4th")
        shared.quarter_four_end |> Momento.format("Qo") |> expect |> to(eql "4th")        
      end
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

    describe "unknown" do
      before do
        {:shared, datetime: %DateTime{Momento.date! | year: 2016, month: 7, day: 6}}
      end

      it "should keep unknown tokens" do
        shared.datetime |> Momento.format("YYYY-MM-DD") |> expect |> to(eql "2016-07-06")
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
