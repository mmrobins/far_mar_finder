require 'csv'
require 'time'

# This file is to require all of our dependencies (each of the classes we make)
require_relative 'far_mar/market'
require_relative 'far_mar/vendor'
require_relative 'far_mar/product'
require_relative 'far_mar/sale'

# puts FarMar::Market.all

# puts FarMar::Sale.inspect
 puts FarMar::Sale.between("November 13, 2013 08:32", "November 13, 2013 08:36")

# s = CSV.read("support/sales.csv")
# sorted = s.sort_by { |s| s[2] }

# puts sorted
