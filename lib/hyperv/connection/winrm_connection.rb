require 'winrm'
require 'winrm-fs'

module HyperV
  module Connection
    class WinRMConnection
      attr_reader :endpoint, :user, :password, :conn, :fs

      # Method to create connection
      def initialize(endpoint:, user:, password:)
        @endpoint = endpoint
        @user = user
        @password = password

        @conn = WinRM::Connection.new(
          endpoint: endpoint,
          user: user,
          password: password,
          transport: :ssl,
          no_ssl_peer_verification: true,
	        disable_sspi: false
        )

        @fs = WinRM::FS::FileManager.new(@conn)
      end

      # Method to test file manager
      def upload_test
        fs.upload("local_test.txt", "C:\\Windows\\Temp\\local_test.txt")
      end

      # Method to run commands
      def run(command)
        @conn.shell(:powershell) do |shell|
          shell.run(command)
        end
      end



      # Method to test "hostname" command

      def test_hostname
        result = run("hostname")
        result.stdout.strip
      end

      def os_version
        result = run("Get-ComputerInfo | Select-Object -ExpandProperty OsName")
        result.stdout.strip
      end

      def vm_list
        result = run("Get-VM")
        result.stdout
      end

    end
  end
end
