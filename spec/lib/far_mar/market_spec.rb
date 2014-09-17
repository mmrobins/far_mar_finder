require 'spec_helper'
describe FarMar::Market do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Market).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Market.all.count).to eq 500
    end

    it "responds to 'find'" do
      expect(FarMar::Market).to respond_to :find
    end

    it "responds to 'search'" do
      expect(FarMar::Market).to respond_to :search
    end

    it "should return market #1 for a zip search of 97202" do
      expect(FarMar::Market.find_by_zip("97202").id).to eq 1
    end

    it "returns market 1 for the address '30th and Burnside'" do
      expect(FarMar::Market.find_by_address('30th and Burnside').id).to eq 1
    end

    it "finds market #1 for city PORTLAND" do
      expect(FarMar::Market.find_by_city("PORTLAND").id).to eq 1
    end

    it "finds market #1 for county 'Multnomah'" do
      expect(FarMar::Market.find_by_county("multNOmah").id).to eq 1
    end

    it "finds market #1 for state 'Oregon'" do
      expect(FarMar::Market.find_by_state("oreGON").id).to eq 1
    end

    # it "'search('school') should return array of 3" do
    #   school_results = FarMar::Market.search("school")
    #   expect(school_results.count).to eq 3
    # end
    #
    # it "'search('school') should find the market with id 75" do
    #   ids = FarMar::Market.search("school").collect { |hit| hit.id }
    #   expect(ids.include? 75)
    # end
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

    describe "#prefered_vendor" do
      it "responds" do
        expect(FarMar::Market.new({})).to respond_to :prefered_vendor
      end

      it "returns a vendor object" do
        expect((market.prefered_vendor).class).to eq FarMar::Vendor
      end

      it "returns vendor #5" do
        expect((market.prefered_vendor).id).to eq 5
      end

      it "returns a vendor object when given a date" do
        expect(market.prefered_vendor(Date.new(2013,11,8)).class).to eq FarMar::Vendor
      end

      it "returns nil when given a date with no sales" do
        expect(market.prefered_vendor(Date.new(500,11,8))).to eq nil
      end
    end

    describe "#worst_vendor" do
      it "returns a vendor object" do
        expect((market.worst_vendor).class).to eq FarMar::Vendor
      end

      it "returns vendor #6" do
        expect((market.worst_vendor).id).to eq 6
      end

      it "returns a vendor object when given a date" do
        expect(market.worst_vendor(Date.new(2013,11,8)).class).to eq FarMar::Vendor
      end

      it "returns nil when given a date with no sales" do
        expect(market.worst_vendor(Date.new(500,11,8))).to eq nil
      end
    end
  end
end
