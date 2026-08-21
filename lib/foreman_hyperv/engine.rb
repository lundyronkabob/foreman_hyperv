module ForemanHyperv
  class Engine < ::Rails::Engine
    engine_name 'foreman_hyperv'

    initializer 'foreman_hyperv.register_provider' do
      ::ComputeResource.register_provider(
        :hyperv,
        'ComputeResources::ForemanHyperv::Hyperv'
      )
    end
  end
end
