# encoding: utf-8

require 'date'
require 'json'
require 'net/http'
require 'singleton'

require 'dbservice/client'
require 'dbservice/channel'
require 'dbservice/program'
require 'dbservice/connection'

module DBService
  class << Version = [1,0]
    def to_s; join '.' end
  end

module_function

  def method_missing name, *args
    Client.instance.__send__ name, *args
  end
end
