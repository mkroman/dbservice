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

    def programs_for channel, time = Time.now
      case channel
      when Channel
        params = {
               broadcastDate: broadcast_date(time),
          channel_source_url: channel.source_url }

        transmit(:getSchedule, params).map &Program.method(:new)
      when Array
        result = []

        channel.each_slice 5 do |slice|
          params = {
            channelList: slice.map(&:source_url),
            broadcastDate: broadcast_date(time) }

          transmit(:getSchedules, params)["programs"].each do |programs|
            result.push programs.map &Program.method(:new)
          end
        end

        result
      end
    rescue Errno::ECONNRESET
      retry
    end

    def synchronize_channels
      programs_for(channels).each_with_index do |list, index|
        channels[index].synchronize list
      end
    end

  private

    def retrieve_channels
      transmit(:getChannels, type: :tv).map &Channel.method(:new)
    end

    def broadcast_date time
      time.strftime "%Y-%m-%d"
    end

    def transmit *args
      @connection.transmit *args
    end

  end
end
