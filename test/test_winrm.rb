#!/usr/bin/env ruby

require_relative '../lib/foreman_hyperv/connection/winrm_connection'
require_relative '../lib/foreman_hyperv/connection/command_runner'

conn = HyperV::Connection::WinRMConnection.new(
  host: "kaamshaam.cheeky.local",
  user: "hb19867",
  password: "t0Ph3rqu3z<3navu"
)

runner = HyperV::Connection::CommandRunner.new(conn)

result = runner.run_ps("Get-VM | Select-Object Name | ConvertTo-Json")

puts "Exitcode: #{result[:exitcode]}"
puts "STDOUT:"
puts result[:stdout]
puts "STDERR:"
puts result[:stderr]

