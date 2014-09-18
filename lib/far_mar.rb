require 'csv'
require 'time'
require 'date'

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
#puts "This vendor's revenue is: #{FarMar::Vendor.find(1).revenue}"
 # puts FarMar::Product.by_vendor(17).count
 # puts FarMar::Product.by_vendor(18).count
# puts FarMar::Market.search('School').inspect
#a = FarMar::Market.all + FarMar::Vendor.all
#puts FarMar::Market.all.count
#puts FarMar::Vendor.all.count
#puts a

#markets_vendors = FarMar::Vendor.all.concat(FarMar::Market.all)
#puts markets_vendors.count
# puts FarMar::Market.find(1).prefered_vendor
# puts FarMar::Market.find(1).prefered_vendor.name
#
# puts FarMar::Market.find(1).prefered_vendor.id
# puts FarMar::Vendor.find(5).revenue
# puts "Worst Vendor on November 10, 2013"
# puts FarMar::Market.find(1).worst_vendor_by_date("November 10, 2013")
# puts FarMar::Market.find(1).worst_vendor_by_date("November 10, 2013").name
# puts FarMar::Market.find(1).worst_vendor_by_date("November 10, 2013").id
# puts FarMar::Market.find(1).worst_vendor_by_date("November 10, 2013").revenue
# puts
# puts "Best Vendor on November 10, 2013"
# puts FarMar::Market.find(1).prefered_vendor_by_date("November 10, 2013")
# puts "Name is #{FarMar::Market.find(1).prefered_vendor_by_date("November 10, 2013").name}"
# puts "ID is #{FarMar::Market.find(1).prefered_vendor_by_date("November 10, 2013").id}"
# puts "Revenue is: #{FarMar::Market.find(1).prefered_vendor_by_date("November 10, 2013").revenue}"

#FarMar::Vendor.most_revenue(5).each {|v| puts v.name + ":  " + v.revenue.to_s}
#puts FarMar::Vendor.most_revenue.name
#puts FarMar::Vendor.find(2590).name
#puts FarMar::Vendor.find(2590).revenue
# puts FarMar::Vendor.most_items(5)
# FarMar::Vendor.most_items(5).each {|v| puts v.name + ":  " + v.sales.count.to_s}

#puts FarMar::Vendor.find(1).sales_for_day("November 10, 2013")
puts FarMar::Vendor.revenue("November 10, 2013")
