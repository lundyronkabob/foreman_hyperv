require_relative "../lib/hyperv/connection/winrm_connection"

conn = HyperV::Connection::WinRMConnection.new(
  endpoint: "https://kaamshaam.cheeky.local:5986/wsman",
  user: "hb19867",
  password: "t0Ph3rqu3z<3navu"
)

puts "Testing hostname..."
hostname = conn.test_hostname
puts "Hostname returned: #{hostname}"

puts conn.vm_list

puts conn.os_version
