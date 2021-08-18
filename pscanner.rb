#!/usr/bin/env ruby

=begin
Author:Sato Raiden
Lang:Ruby
License:GPL
=end

require 'socket'

PORT = ARGV[1] || nil
HOST = ARGV[0] || nil

def usage_rem
    puts "Usage: ./poping.rb <host> <port>"
    puts "\t Example: ./poping.rb 192.168.2.11 443"
end

if  PORT == nil || HOST == nil 
    usage_rem()
elsif PORT == nil && HOST == nil
    usage_rem()
else
    puts "[+] Scanning on #{HOST} for port #{PORT}"

    begin
        s = TCPSocket.new(HOST, PORT)
        pstatus = "OPEN"
    rescue Errno::ECONNREFUSED, SocketError
        pstatus = "REFUSE"
    rescue Errno::ETIMEDOUT
        pstatus = "TIMEOUT"
    end

    if pstatus == "OPEN"
        puts "[+] Port #{PORT} is open on #{HOST}"
    elsif pstatus == "REFUSE"
        puts "[-] #{HOST} seems down or doesn't exist."
    elsif pstatus == "TIMEOUT"
        puts "[-] Timed out sending request."
    else
        puts "You rocked it #{nil}."
    end
end