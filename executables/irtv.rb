#!/usr/bin/env ruby
# encoding: utf-8

$:.unshift File.dirname(__FILE__) + '/../library'
require 'dbservice'

DBService::Client.instance.tap do |this|
  #this.synchronize_channels

  #this.channels[0]].each do |channel|
  channel = this.channels.first
    puts ".. #{channel.name}"

=begin
    channel.programs.each do |program|
      puts "    [#{program.start.strftime "%H:%M:%S"}] #{program.title}"
    end
=end

    if program = channel.previous
      puts "    #{program.start.strftime "[%H:%M:%S]"} #{program.title}"
    else
      puts "    Nothing"
    end
  #end
end
