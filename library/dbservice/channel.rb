# encoding: utf-8

module DBService
  class Channel
    def [] key; @attributes[key] end

    def initialize attributes
      @attributes, @programs = attributes, nil
    end

    def synchronize programs
      @programs = programs
    end

    def programs
      @programs ||= DBService.programs_for self
    rescue Errno::ECONNRESET
      retry
    end

    def next
      programs.find { |program| program.start >= now }
    end

    def previous
      programs.select { |program| program.start < now && program.end < now }.last
    end

    def current
      programs.find { |program| program.start < now && program.end > now }
    end

    def now; DateTime.now end

    def method_missing name, *args
      @attributes[name.to_s]
    end
  end
end
