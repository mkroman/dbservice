# encoding: utf-8

module DBService
  class Client
    include Singleton

    def initialize
      @connection = Connection.new
    end

    def search query
      @connection.transmit :getChannels, type: 'tv'
    end

    def channels
      @channels ||= @connection.transmit(:getChannels, type: :tv).tap do |response|
        # TODO
      end
    end

  end
end
