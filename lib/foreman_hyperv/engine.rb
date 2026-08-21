module ForemanHyperv
  class Engine < ::Rails::Engine
    engine_name 'foreman_hyperv'

    initializer 'foreman_hyperv.register_plugin', before: :finisher_hook do |app|
      app.reloader.to_prepare do
        Foreman::Plugin.register :foreman_hyperv do
          requires_foreman '>=3.0'
          compute_resource ComputeResources::ForemanHyperv::Hyperv
        end
      end
    end
  end
end
