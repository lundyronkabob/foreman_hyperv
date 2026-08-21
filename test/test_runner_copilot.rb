#!/usr/bin/env ruby

require_relative 'lib/hyperv/connection/winrm_connection'
require_relative 'lib/hyperv/connection/command_runner'

# 1. Build the WinRM connection
conn = HyperV::Connection::WinRMConnection.new(
  endpoint: "http://YOUR-HYPERV-HOST:5985/wsman",
  user:     "Administrator",
  password: "YOURPASSWORD"
)

# 2. Build the Command Runner
runner = HyperV::Connection::CommandRunner.new(conn)

# 3. Run a PowerShell command
result = runner.run_ps("Get-VM")

# 4. Print the results
puts "STDOUT:"
puts result[:stdout]

puts "\nSTDERR:"
puts result[:stderr]

puts "\nEXITCODE:"
puts result[:exitcode]
