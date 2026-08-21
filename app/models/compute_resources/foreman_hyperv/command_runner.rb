module HyperV
  module Connection
    class CommandRunner

      def initialize(connection)
        @connection = connection
      end

      def run_ps(command)
        shell = @connection.conn.shell(:powershell)
        result = shell.run(command)
        shell.close

        {
          stdout:   result.stdout,
          stderr:   result.stderr,
          exitcode: result.exitcode
        }
      end

      def run_raw(command)
        shell = @connection.conn.shell(:powershell)
        result = shell.run(command)
        shell.close
        result
      end

    end
  end
end
