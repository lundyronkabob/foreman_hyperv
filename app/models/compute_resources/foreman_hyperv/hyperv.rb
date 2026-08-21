require_dependency 'hyper_v/connection/winrm_connection'
require_dependency 'hyper_v/connection/command_runner'
require_dependency 'hyper_v/vm_manager'
require_dependency 'hyper_v/vm'



module ComputeResources
  module ForemanHyperv
    class Hyperv < ::ComputeResource

      def self.model_name
        ComputeResource.model_name
      end

      def provider_friendly_name
        "Hyper-V"
      end

      def provided_attributes
        {
          endpoint: '',
          user: '',
          password: '',
          transport: 'ssl'
        }
      end

      def hyperv_client
        ::HyperV::Connection::WinRMConnection.new(
          endpoint: self.url,
          user: self.user,
          password: self.password,
          transport: self.attrs[:transport]
        )
      end

      def test_connection
        client = hyperv_client
        client.test_hostname.present?
      rescue => e
        raise ::Foreman::Exception.new("Hyper-V connection failed: #{e}")
      end

    end
  end
end
