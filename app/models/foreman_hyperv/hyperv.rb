require_dependency 'foreman_hyperv/winrm_connection'
require_dependency 'foreman_hyperv/command_runner'
require_dependency 'foreman_hyperv/vm_manager'
require_dependency 'foreman_hyperv/vm'

  module ForemanHyperv
    class Hyperv < ::ComputeResource

      def self.model_name
        ComputeResource.model_name
      end

      def provider_friendly_name
        "Hyper-V"
      end

      def provided_attributes
        super.merge(
          url: :string,
          user: :string,
         password: :string,
          transport: :string 
        )
      end

      def hyperv_client
        normalized = normalize_url_value(self.url, self.transport)

        WinrmConnection.new(
          endpoint: normalized,
          user: self.user,
          password: self.password,
          transport: self.attrs[:transport]
        )
      end

      def normalize_url_value(raw, transport)
        hostname = raw.to_s.strip

        if transport.to_s == 'plaintext'
          scheme = 'http'
          port   = 5985
        else
          scheme = 'https'
          port   = 5986
        end

        "#{scheme}://#{hostname}:#{port}/wsman"
      end

      def supports_vms?
        true
      end

      def supports_power?
        true
      end

      def vms(*args)
        runner  = ForemanHyperv::CommandRunner.new(hyperv_client)
        manager = ForemanHyperv::VMManager.new(runner)

        vms = manager.list_vms.map do |vm|
          ForemanHyperv::ForemanVM.new(
            compute_resource: self,
            id: vm.id,
            name: vm.name,
            state: vm.normalized_state,
            memory: vm.normalized_memory,
            cpus: vm.cpu_count
          )
        end

        ForemanHyperv::VMCollection.new(vms)
      end


     def capabilities
       []
     end

      def test_connection(_unused = nil)
        client = hyperv_client
        client.test_hostname.present?
      rescue => e
        raise ::Foreman::Exception.new("Hyper-V connection failed: #{e}")
      end

      def validate_connection(_unused = nil)
        test_connection
      end

      def connection_valid?(_unused = nil)
        test_connection
      rescue
        false
      end

      def transport
        attrs[:transport].to_s.presence || "https"
      end

      def transport=(value)
        attrs[:transport] = value
      end

      def user
        attrs[:user]
      end

      def user=(value)
        attrs[:user] = value
      end

      def password
        attrs[:password]
      end

      def password=(value)
        attrs[:password] = value
      end

      def start(vm)
        ps = "Get-VM -Id \"#{vm.id}\" | Start-VM"
        result = hyperv_client.run_ps(ps)
        raise ::Foreman::Exception.new("Start-VM failed: #{result[:stderr]}") if result[:exitcode] != 0
        true
      end

      def stop(vm)
        ps = "Get-VM -Id \"#{vm.id}\" | Stop-VM"
        result = hyperv_client.run_ps(ps)
        raise ::Foreman::Exception.new("Stop-VM failed: #{result[:stderr]}") if result[:exitcode] != 0
        true
      end

      def reboot(vm)
        ps = "Get-VM -Id \"#{vm.id}\" | Restart-VM"
        result = hyperv_client.run_ps(ps)
        raise ::Foreman::Exception.new("Restart-VM failed: #{result[:stderr]}") if result[:exitcode] != 0
        true
      end

      def reset(vm)
        ps = "Get-VM -Id \"#{vm.id}\" | Restart-VM -Force"
        result = hyperv_client.run_ps(ps)
        raise ::Foreman::Exception.new("Reset-VM failed: #{result[:stderr]}") if result[:exitcode] != 0
        true
      end

    end
  end
