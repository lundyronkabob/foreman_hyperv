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
        WinrmConnection.new(
          endpoint: self.url,
          user: self.user,
          password: self.password,
          transport: self.attrs[:transport]
        )
      end

     def capabilities
       [:build]
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

    end
  end
