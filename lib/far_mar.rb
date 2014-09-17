require 'csv'
require 'time'

# This file is to require all of our dependencies (each of the classes we make)
require_relative 'far_mar/market'
require_relative 'far_mar/vendor'
require_relative 'far_mar/product'
require_relative 'far_mar/sale'

# puts FarMar::Market.all

# puts FarMar::Sale.inspect
 # puts FarMar::Sale.between("November 13, 2013 08:32", "November 13, 2013 08:36")

# s = CSV.read("support/sales.csv")
# sorted = s.sort_by { |s| s[2] }

# puts sorted

# puts FarMar::Market.all[9].products.count

# puts FarMar::Market.find(5).vendors.count

# puts FarMar::Vendor.all[16].products.count
#
# puts FarMar::Vendor.all[17].products.count
#
#puts FarMar::Market.find(5).products.count
puts "This vendor's revenue is: #{FarMar::Vendor.find(1).revenue}"
 # puts FarMar::Product.by_vendor(17).count
 # puts FarMar::Product.by_vendor(18).count
