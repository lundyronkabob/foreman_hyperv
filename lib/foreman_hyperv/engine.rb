module ForemanHyperv
  class Engine < ::Rails::Engine
    engine_name 'foreman_hyperv'

    initializer 'foreman_hyperv.register_compute_resource' do
      ::ComputeResource.register_provider(:hyperv, 'ComputeResources::HyperV')

    end
  end

end