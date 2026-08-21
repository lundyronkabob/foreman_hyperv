require 'winrm'
require 'winrm-fs'

module ComputeResources
  module ForemanHyperv
    class WinrmConnection
      attr_reader :endpoint, :user, :password, :transport, :conn, :fs

      def initialize(endpoint:, user:, password:, transport: nil)
        @endpoint = normalize_endpoint(endpoint)
        @user = user
        @password = password
        @transport = transport || detect_transport(@endpoint)

        @conn = build_connection
        @fs = WinRM::FS::FileManager.new(@conn)
      end

      def normalize_endpoint(ep)
        ep = ep.to_s.strip
        return ep if ep.end_with?('/wsman')
        "#{ep}/wsman"
      end

      def detect_transport(ep)
        return :ssl       if ep.start_with?('https://')
        return :plaintext if ep.start_with?('http://')
        :ssl
      end

      def build_connection
        case @transport
        when :ssl
          WinRM::Connection.new(
            endpoint: @endpoint,
            user:     @user,
            password: @password,
            transport: :ssl,
            no_ssl_peer_verification: true,
            disable_sspi: false
          )
        when :plaintext
          WinRM::Connection.new(
            endpoint: @endpoint,
            user:     @user,
            password: @password,
            transport: :plaintext,
            disable_sspi: false
          )
        else
          raise ArgumentError, "Unsupported transport: #{@transport}"
        end
      end

      def upload_test
        fs.upload("local_test.txt", "C:\\Windows\\Temp\\local_test.txt")
      end

      def run(command)
        shell = @conn.shell(:powershell)
        result = shell.run(command)
        shell.close
        result
      end

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
