require_relative 'lib/hyperv/connection/winrm_connection'
require_relative 'lib/hyperv/connection/command_runner'
require_relative 'lib/hyperv/vm'
require_relative 'lib/hyperv/vm_manager'


conn = HyperV::Connection::WinRMConnection.new(
	endpoint: "https://kaamshaam.cheeky.local:5986/wsman",
	user:	  "hb19867",
	password: "t0Ph3rqu3z<3navu"
)

runner	= HyperV::Connection::CommandRunner.new(conn)
manager = HyperV::VMManager.new(runner)

vms = manager.list_vms

vms.each do |vm|
	puts "#{vm.name} - #{vm.normalized_state} - #{vm.cpu_usage}% CPU - #{vm.normalized_memory} - #{vm.normalized_uptime}"

end
