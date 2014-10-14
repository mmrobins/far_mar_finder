require 'spec_helper'

describe FarMar::Vendor do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Vendor).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Vendor.all.count).to eq 2690
    end

    it "responds to 'find'" do
      expect(FarMar::Vendor).to respond_to :find
    end

    it "responds to 'by_market'" do
      expect(FarMar::Vendor).to respond_to :by_market
    end

    it "finds the first vendor by market 1" do
      expect(FarMar::Vendor.by_market(100).first.name).to eq "Schiller-Ledner"
    end

    describe "#most_revenue" do
      let(:rev_array) { FarMar::Vendor.most_revenue(3)}
      it "returns an array of vendor objects" do
        expect((rev_array[0]).class).to eq FarMar::Vendor
      end

      it "returns an array length 3 for top 3" do
        expect(rev_array.length).to eq 3
      end


    end

    describe "#self.most_items" do
      let(:sales_array) { FarMar::Vendor.most_items(3) }
      it "returns an array of vendor objects" do
        expect((sales_array[0]).class).to eq FarMar::Vendor
      end

      it "returns an array length 3 for top 3" do
        expect(sales_array.length).to eq 3
      end
    end

    describe "#self.revenue" do
      let(:all_revenue) {FarMar::Vendor.revenue}
      let(:date_revenue) { FarMar::Vendor.revenue(Date.new(2013,11,13)) }
      it "should return an integer" do
        expect(all_revenue.class).to eq Fixnum
      end

      it "should return an integer when given a valid date" do
        expect(date_revenue.class).to eq Fixnum
      end
    end

  end

  describe "attributes" do
    let(:vendor) { FarMar::Vendor.find(10) }
    # 10,Kertzmann LLC,11,3

    it "has the id 10" do
      expect(vendor.id).to eq 10
    end
    it "has the name" do
      expect(vendor.name).to eq "Kertzmann LLC"
    end
    it "has the no of employees 11" do
      expect(vendor.no_of_employees).to eq 11
    end
    it "has the market_id 3" do
      expect(vendor.market_id).to eq 3
    end
  end

  describe "#revenue" do
    let(:vendor) { FarMar::Vendor.find(2) }

    it "returns 0 when given a date with no sales" do
      expect(vendor.revenue(Date.new(500,11,8))).to eq 0
    end
  end

  describe "associations" do
    let(:vendor) { FarMar::Vendor.find(1) }

    it "responds to :market" do
      expect(vendor).to respond_to :market
    end

    it "market_id matches the markets id" do
      expect(vendor.market.id).to eq vendor.market_id
    end

    it "responds to :sales" do
      expect(vendor).to respond_to :sales
    end

    it "has 7 sales" do
      expect(vendor.sales.count).to eq 7
    end

    it "responds to products" do
      expect(vendor).to respond_to :products
    end

    it "has 1 products" do
      expect(vendor.products.count).to eq 1
    end
  end

end
