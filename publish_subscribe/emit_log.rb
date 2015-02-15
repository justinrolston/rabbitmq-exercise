#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require 'securerandom'

conn = Bunny.new(automatically_recover: false)
conn.start

ch   = conn.create_channel
x    = ch.fanout("logs")

random_string = SecureRandom.hex

msg  = ARGV.empty? ? "Hello - #{random_string}" : ARGV.join(" ")

x.publish(msg)
puts " [x] Sent #{msg}"

conn.close
