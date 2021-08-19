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
else
    puts "[+] Scanning on #{HOST} for port #{PORT}"

    begin
        s = TCPSocket.new(HOST, PORT)
        puts "[+] Port #{PORT} is open on #{HOST}"
    rescue Errno::ECONNREFUSED
        puts "[-] #{PORT} is closed on #{HOST}"
    rescue SocketError
        puts "[-] Sad (T_T) can't connect to #{HOST}"
    rescue Errno::ETIMEDOUT
        puts "[-] Timed out sending request."
    rescue Interrupt
        puts "\nAbort! Uwu star me on github: https://github.com/hackerW1/PSCollection"
    end
end
