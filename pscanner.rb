#!/usr/bin/env ruby

=begin

Author: Sato Raiden
Lang:   Ruby
License:GPL

=end

require 'socket'

PORT = ARGV[1] || 443
HOST = ARGV[0] || 'google.com'

begin
    socket = TCPSocket.new(HOST, PORT)
    status = "open"
rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
    status = "close"
end

puts "[+] #{PORT} is #{status}"