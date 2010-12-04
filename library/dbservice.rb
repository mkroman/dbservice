# encoding: utf-8

require 'json'
require 'net/http'
require 'singleton'

require 'dbservice/client'
require 'dbservice/channel'
require 'dbservice/connection'

module DBService
  class << Version = [1,0]
    def to_s; join '.' end
  end

module_function

  def search *args; client.search *args end
  def client; Client.instance end
end
