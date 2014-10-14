module FarMar
  class Aspect

    def self.all
      @object_array ||= load_file(@path).collect { |obj| new(obj) }
    end

    def self.all_by_id
      @object_hash ||= Hash[*all.map {|o| [o.id, o]}.flatten]
    end

    def self.load_file(file_path)
      CSV.read(file_path)
    end

    def self.set_path(path)
      @path = path
    end

    def self.find(id)
      all_by_id[id]
    end

    def self.find_by_name(search_term)
      if self.inspect == "FarMar::Sale"
        return nil
      else
        search_term.downcase!
        all.find { |object| object.name.downcase == search_term }
      end
    end

    def self.find_all_by_name(search_term)
      if self.inspect == "FarMar::Sale"
        return nil
      else
        search_term.downcase!
        all.find_all { |object| object.name.downcase.include? search_term }
      end
    end
  end
end
