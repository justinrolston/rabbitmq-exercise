#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require 'securerandom'

conn = Bunny.new(automatically_recover: false)
conn.start

ch   = conn.create_channel
q    = ch.queue("task_queue", durable: true)

random_string = SecureRandom.hex

msg  = ARGV.empty? ? "Hello - #{random_string}" : ARGV.join(" ")

q.publish(msg, persistent: true)
puts " [x] Sent #{msg}"

conn.close
