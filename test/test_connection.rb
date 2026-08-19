require_relative "../lib/hyperv/connection/winrm_connection"

conn = HyperV::Connection::WinRMConnection.new(
  endpoint: "https://kaamshaam.cheeky.local:5986",
  user: "hb19867",
  password: "t0Ph3rqu3z<3navu"
)

puts "Uploading test file..."
conn.upload_test
puts "Upload complete."
