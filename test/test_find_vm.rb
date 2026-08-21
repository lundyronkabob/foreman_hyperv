require_relative 'lib/hyperv/connection/winrm_connection'
require_relative 'lib/hyperv/connection/command_runner'
require_relative 'lib/hyperv/vm_manager'

conn = HyperV::Connection::WinRMConnection.new(
  endpoint: "https://kaamshaam.cheeky.local:5986/wsman",
  user:     "hb19867",
  password: "t0Ph3rqu3z<3navu"
)

runner  = HyperV::Connection::CommandRunner.new(conn)
manager = HyperV::VMManager.new(runner)

vm = manager.find_vm("bootsuit.cheeky.local")

puts vm.inspect
