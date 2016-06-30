defmodule GuardsSpec do
  require Momento
  import Momento.Guards
  use ESpec

  describe "Custom guards" do
    describe "natural?" do
      it "should be true if positive integer" do
        expect natural?(5) |> to(be_true)
      end

      it "should be true if zero" do
        expect natural?(0) |> to(be_true)
      end

      it "should be false if negative integer" do
        expect natural?(-5) |> to(be_false)
      end
    end

    describe "positive?" do
      it "should be true if positive integer" do
        expect positive?(5) |> to(be_true)
      end

      it "should be false if zero" do
        expect positive?(0) |> to(be_false)
      end

      it "should be false if negative integer" do
        expect positive?(-5) |> to(be_false)
      end
    end

    describe "negative?" do
      it "should be true if negative integer" do
        expect negative?(-5) |> to(be_true)
      end

      it "should be false if zero" do
        expect negative?(0) |> to(be_false)
      end

      it "should be false if positive integer" do
        expect negative?(5) |> to(be_false)
      end
    end

    describe "days_in_month" do
      it "should return the number of days in a given month where input is non-zero indexed" do
        expect days_in_month(2) |> to(eq 28)
      end

      it "should be circular in the forward direction" do
        expect days_in_month(13) |> to(eq 31)
      end

      it "should be circular in the backward direction" do
        expect days_in_month(0) |> to(eq 31)
      end

      it "should not accept integers out of range" do
        expect fn -> days_in_month(14) end |> to(raise_exception ArgumentError, "argument error")
      end
    end
  end
end
