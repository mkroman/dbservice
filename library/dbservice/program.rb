# encoding: utf-8

module DBService
  class Program
    def self.attr_info name, key
      define_method(name) { @attributes[key.to_s] }
    end

    attr_info :title, :ppu_title

    def initialize attributes
      @attributes = attributes
    end

    def end; DateTime.parse pg_stop end
    def start; DateTime.parse pg_start end

    def method_missing name, *args; @attributes[name.to_s] end
  end
end
