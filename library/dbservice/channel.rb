# encoding: utf-8

module DBService
  class Channel

    def initialize client, attributes
      @client, @attributes = client, attributes

      @programs = []
    end

    def [] key; @attributes[key] end

    def programs
      @programs ||= @client.programs_for self
    end
  end
end
