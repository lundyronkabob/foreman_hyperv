require 'json'

module ComputeResources
  module ForemanHyperv
    class VMManager
      def initialize(runner)
        @runner = runner
      end

      def list_vms
        ps = "Get-VM | Select-Object Id,Name,State,CPUUsage,MemoryAssigned,Uptime,Status,Version | ConvertTo-Json"
        result = @runner.run_ps(ps)

        return [] if result[:exitcode] != 0 || result[:stdout].strip.empty?

        parsed = JSON.parse(result[:stdout])
        parsed = [parsed] if parsed.is_a?(Hash)

        parsed.map do |vm|
          VM.new(
            id:               vm["Id"],
            name:             vm["Name"],
            state:            vm["State"],
            cpu_usage:        vm["CPUUsage"],
            memory_assigned:  vm["MemoryAssigned"],
            uptime:           vm["Uptime"],
            status:           vm["Status"],
            version:          vm["Version"]
          )
        end
      end

      def find_vm_by_name(name)
        ps = "Get-VM -Name \"#{name}\" | Select-Object Id,Name,State,CPUUsage,MemoryAssigned,Uptime,Status,Version | ConvertTo-Json"
        result = @runner.run_ps(ps)

        return nil if result[:exitcode] != 0 || result[:stdout].strip.empty?

        vm = JSON.parse(result[:stdout])

        VM.new(
          id:               vm["Id"],
          name:             vm["Name"],
          state:            vm["State"],
          cpu_usage:        vm["CPUUsage"],
          memory_assigned:  vm["MemoryAssigned"],
          uptime:           vm["Uptime"],
          status:           vm["Status"],
          version:          vm["Version"]
        )
      end

      def find_vm(uuid)
        find_vm_by_name(uuid)
      end
    end
  end
end
