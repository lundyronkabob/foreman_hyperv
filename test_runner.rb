#!/usr/bin/env ruby

require_relative 'lib/hyperv/connection/winrm_connection'
require_relative 'lib/hyperv/connection/command_runner'

# 1. Build the WinRM Connection

conn = HyperV::Connection::WinRMConnection.new(
	endpoint: 	"https://kaamshaam.cheeky.local:5986/wsman",
	user:		"hb19867",
	password:	"t0Ph3rqu3z<3navu"
)

# 2. Build the Command Runner

runner = HyperV::Connection::CommandRunner.new(conn)

# 3. Run a Powershell Command

result = runner.run_ps("Get-VM")

# 4. Print the results

puts "STDOUT:"
puts result[:stdout]

puts "\nSTDERR:"
puts result[:stderr]

puts "\nEXITCODE:"
puts result[:exitcode]

