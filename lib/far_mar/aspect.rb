module FarMar
  class Aspect

    def self.all()
    end

    def self.find(id)
      all.find { |object| object.id == id }
    end

    def find_by_name(search_term)
      search_term.downcase!
      all.find { |object| object.name.downcase == search_term }
    end
