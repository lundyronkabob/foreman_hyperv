module ForemanHyperv
  class Engine < ::Rails::Engine
    engine_name 'foreman_hyperv'

    # Make Rails autoload your lib directory
    config.autoload_paths << "#{ForemanHyperv::Engine.root}/lib"

    initializer 'foreman_hyperv.register_provider' do
      ::ComputeResource.register_provider(:hyperv, 'ComputeResources::HyperV')
    end
  end
end
