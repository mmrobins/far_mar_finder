module FarMar
  class Aspect

    def self.all
      @object_array ||= load_file(get_file_path).collect { |obj| new(obj) }
    end

    def self.load_file(file_path)
      CSV.read(file_path)
    end

    def self.get_file_path
      case self.inspect
      when "FarMar::Market"
        "./support/markets.csv"
      when "FarMar::Product"
        "./support/products.csv"
      when "FarMar::Sale"
        "./support/sales.csv"
      when "FarMar::Vendor"
        "./support/vendors.csv"
      when "FarMar::Aspect"
        abort("oh no! don't do that!")
      else
        puts self.inspect
        puts "Add to the case statement for your new class."
      end
    end


    def self.find(id)
      all.find { |object| object.id == id }
    end

    def self.find_by_name(search_term)
      search_term.downcase!
      all.find { |object| object.name.downcase == search_term }
    end
  end
end
