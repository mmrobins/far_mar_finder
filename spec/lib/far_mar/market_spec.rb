require 'spec_helper'
describe FarMar::Market do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Market).to respond_to :all
    end

    it "'all' should return" do
      puts FarMar::Market.all.count

      expect(FarMar::Market.all.count).to eq 500
    end

    it "responds to 'find'" do
      expect(FarMar::Market).to respond_to :find
    end

    it "responds to 'search'" do
      expect(FarMar::Market).to respond_to :search
    end

    it "returns market instance results based on a search term" do
      expect(FarMar::Market.search('school').count).to eq 3
    end

    it "returns market name based on a search term" do
      expect(FarMar::Market.search('school')[0].name).to eq "Fox School Farmers Market"
    end

  end

  describe "attributes" do
    let(:market) { FarMar::Market.find(1) }
    # 1,People's Co-op Farmers FarMar::Market,30,Portland,Multnomah,Oregon,97202

    it "has the id 1" do
      expect(market.id).to eq 1
    end

    it "has the name 'People's Co-op Farmers FarMar::Market'" do
      expect(market.name).to eq "People's Co-op Farmers Market"
    end

    it "has the address '30th and Burnside'" do
      expect(market.address).to eq "30th and Burnside"
    end

    it "has the city 'Portland'" do
      expect(market.city).to eq "Portland"
    end
    it "has the county 'Multnomah'" do
      expect(market.county).to eq "Multnomah"
    end
    it "has the state 'Oregon'" do
      expect(market.state).to eq "Oregon"
    end
    it "has the zip '97202'" do
      expect(market.zip).to eq "97202"
    end

  end

  describe "instance methods" do
    let(:market) { FarMar::Market.find(1) }
    it "responds to vendors" do
      expect(FarMar::Market.new({})).to respond_to :vendors
    end

    it "finds the vendors" do
      expect(market.vendors.first.id).to eq 1
    end

    it "return all products for each vendor in the market" do
      expect(market.products.count).to eq 13
    end

    it 'responds to prefered_vendor' do
      expect(market).to respond_to :prefered_vendor
    end

    it 'returns highest revenue' do
      expect(market.prefered_vendor.name).to eq " "
    end
  end
end
