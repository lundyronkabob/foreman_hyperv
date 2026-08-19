module HyperV
  module Connection
    class WinRMConnection
      attr_reader :endpoint, :user, :password, :transport

      def initialize(endpoint:, user:, password:, transport:)
        @endpoint  = endpoint
        @user      = user
        @password  = password
        @transport = transport
      end

      def client
        ::WinRM::Connection.new(
          endpoint: endpoint,
          user: user,
          password: password,
          transport: transport
        )
      end

      def test_hostname
        shell = client.shell(:powershell)
        output = shell.run("hostname")
        output.stdout.strip
      rescue => e
        raise "WinRM hostname test failed: #{e}"
      ensure
        shell&.close
      end



    end
  end
end