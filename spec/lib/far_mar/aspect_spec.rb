require 'spec_helper'
describe FarMar::Aspect do

  describe "#find(id)" do
    it "returns the correct market for id search of 2" do
      expect(FarMar::Market.find(2).name).to eq "Silverdale Farmers Market"
    end

    it "returns the correct vendor for id search of 35" do
      expect(FarMar::Vendor.find(35).name).to eq "Runolfsdottir Inc"
    end

    it "returns the correct product for id search of 22" do
      expect(FarMar::Product.find(22).name).to eq "Purring Beets"
    end

    it "returns the correct sale amount for id search of 2" do
      expect(FarMar::Sale.find(2).amount).to eq 2262
    end

  end

  describe "#find_by_name" do
     it "returns the correct market id for name search" do
       expect(FarMar::Market.find_by_name("Silverdale Farmers Market").id).to eq 2
     end

     it "returns the correct vendor id for name search" do
       expect(FarMar::Vendor.find_by_name("Runolfsdottir Inc").id).to eq 35
     end

     it "returns the correct product id for name search" do
       expect(FarMar::Product.find_by_name("Purring Beets").id).to eq 22
     end

     it "returns nil for name search on sale" do
       expect(FarMar::Sale.find_by_name("meow")).to eq nil
     end

  end

  describe "#find_all_by_name" do

    it "returns the correct market count for name search" do
      expect(FarMar::Market.find_all_by_name("Farmer's").count).to eq 20
    end

    it "returns the correct vendor count for name search" do
      expect(FarMar::Vendor.find_all_by_name("SONS").count).to eq 220
    end

    it "returns the correct product count for name search" do
      expect(FarMar::Product.find_all_by_name("Purring Beets").count).to eq 4
    end

    it "returns nil for name search on sale" do
      expect(FarMar::Sale.find_all_by_name("meow")).to eq nil
    end
  end
end
