#!/usr/bin/env ruby

require_relative '../lib/s2c_client'

console = S2C::Client::Console.new("localhost:4567")
console.run