#!/usr/bin/env ruby

require_relative '../app/models/compute_resources/foreman_hyperv/winrm_connection'
require_relative '../app/models/compute_resources/foreman_hyperv/command_runner'
require_relative '../app/models/compute_resources/foreman_hyperv/vm_manager'
require_relative '../app/models/compute_resources/foreman_hyperv/vm'

HOST     = "kaamshaam.cheeky.local"
USER     = "hb19867"
PASSWORD = "t0Ph3rqu3z<3navu"

ENDPOINT = "http://#{HOST}:5985/wsman"

puts "Initializing WinRM connection..."

conn = ComputeResources::ForemanHyperv::WinrmConnection.new(
  endpoint: ENDPOINT,
  user: USER,
  password: PASSWORD,
  transport: :ssl
)

runner = ComputeResources::ForemanHyperv::CommandRunner.new(conn)

puts "Running basic PowerShell test..."
ps_result = runner.run_ps("Get-VM | Select-Object Name | ConvertTo-Json")

puts "Exitcode: #{ps_result[:exitcode]}"
puts "STDOUT:"
puts ps_result[:stdout]
puts "STDERR:"
puts ps_result[:stderr]

puts "\nInitializing VMManager..."
manager = ComputeResources::ForemanHyperv::VMManager.new(runner)

puts "Listing VMs..."
vms = manager.list_vms

puts "Found #{vms.length} VMs"

vms.each do |vm|
  puts "--------------------------------"
  puts "Name: #{vm.name}"
  puts "State: #{vm.normalized_state}"
  puts "Memory: #{vm.normalized_memory}"
  puts "Uptime: #{vm.normalized_uptime}"
end

