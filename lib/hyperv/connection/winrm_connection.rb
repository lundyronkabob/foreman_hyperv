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
          transport: :negotiate,
          no_ssl_peer_verification: true
        )

        @fs = WinRM::FS::FileManager.new(@conn)
      end

      # Method to test file manager
      def upload_test
        fs.upload("local_test.txt", "C:\\Windows\\Temp\\local_test.txt")
      end

      # Method to create a shell
      def shell
        @conn.shell(:powershell)
      end

      # Method to run commands
      def run(command)
        shell.run(command)
      end

      # Method to test "hostname" command

      def test_hostname
        result = run("hostname")
        result.stdout.strip
      end

    end
  end
end
