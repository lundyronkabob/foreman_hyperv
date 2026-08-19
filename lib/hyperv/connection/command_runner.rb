module HyperV
  module Connection
    class CommandRunner
      
      def initialize(connection)
        @connection = connection
      end

      def run_ps(command)
        @connection.conn.shell(:powershell) do |shell|
          result = shell.run(command)

          {
            stdout:   result.stdout,
            stderr:   result.stderr,
            exitcode: result.exitcode
          }
        end
      end

        def run_raw(command)
          @connection.conn.shell(:powershell) do |shell|
            shell.run(command)
        
          end
        end

    end
  end

end