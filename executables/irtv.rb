#!/usr/bin/env ruby
# encoding: utf-8

$:.unshift File.dirname(__FILE__) + '/../library'
require 'dbservice'

DBService::Client.instance.tap do |this|
  p this.search("simpsons").body
end
