# encoding: utf-8

module DBService
  class JSONRPCError < StandardError; end

  class Connection
    DefaultPath = '/tjenester/programoversigt/dbservice.ashx'
    DefaultHost = 'www.dr.dk'
    DefaultPort = 80

    def initialize host = DefaultHost, port = DefaultPort, path = DefaultPath
      @host, @port, @path, @id = host, port, path, 0

      @http = Net::HTTP.new @host, @port
    end

    def transmit method, params = {}
      response = @http.post DefaultPath, body_for(method, params), headers_for(method)
      json = JSON.parse response.body

      if json['error']
        json['error']['errors'].each do |error|
          raise JSONRPCError, error['message']
        end
      else
        json['result']
      end
    end

  private

    def headers_for method
      { "X-JSON-RPC" => "#{method}" }
    end

    def body_for method, params = {}
      { id: @id += 1, method: "#{method}", params: params }.to_json
    end
  end
end
