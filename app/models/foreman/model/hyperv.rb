module Foreman::Module
  class HyperV < ComputeResource
    
    def initialize(args)
      super
      @args = args
    end

    def vms
      manager.list_vms
    end

    def find_vm(uuid)
      manager.find_vm_by_name(uuid)
    end

    private

    def manager
      @manager ||= begin
        conn = Connection::WinRMConnection.new(
          endpoint: @args[:endpoint],
          user:     @args[:user],
          password: @args[:password]
        )

        runner = HyperV::Connection::CommandRunner.new(conn)
        HyperV::VMManager.new(runner)
      end
    end

  end
end