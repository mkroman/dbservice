# encoding: utf-8

module DBService
  class Client
    include Singleton

    def initialize
      @connection = Connection.new
    end

    def search query
      # …
    end

    def channels
      @channels ||= retrieve_channels
    end

    def programs_for channel
      case channel
      when Channel
        @connection.transmit :getSchedule, channel_source_url: channel['source_url'], broadcastDate: broadcast_date
      when Array
        100
      end
    end

  private

    def retrieve_channels
      @connection.transmit(:getChannels, type: :tv).map do |body|
        Channel.new self, body
      end
    end

    def broadcast_date time = Time.now
      time.strftime "%Y-%m-%d"
    end

  end
end
