module ForemanHyperv
  class ComputeResourcesVmsController < ::ApplicationController
    before_action :find_compute_resource
    before_action :find_vm


    def start
      @compute_resource.start(@vm)
      redirect_back fallback_location: compute_resource_path(@compute_resource),
                    notice: "VM #{@vm.name} started successfully"
      
    rescue => e
      redirect_back fallback_location: compute_resource_path(@compute_resource),
                    alert: "Failed to start VM: #{e.message}"
    end

    def stop
      @compute_resource.stop(@vm)
      redirect_back fallback_location: compute_resource_path(@compute_resource),
                    notice: "VM #{@vm.name} stopped successfully"

    rescue => e
      redirect_back fallback_location: compute_resource_path(@compute_resource),
                    alert: "Failed to stop VM: #{e.message}"
    end

    def reboot
      @compute_resource.reboot(@vm)
      redirect_back fallback_location: compute_resource_path(@compute_resource),
                    notice: "VM #{@vm.name} rebooted successfully"

    rescue => e
      redirect_back fallback_location: compute_resource_path(@compute_resource),
                    alert: "Failed to reboot VM: #{e.message}"
    end

    def reset
      @compute_resource.reset(@vm)
      redirect_back fallback_location: compute_resource_path(@compute_resource),
                    notice: "#{@vm.name} reset successfully"

    rescue => e
      redirect_back fallback_location: compute_resource_path(@compute_resource),
                    alert: "Failed to reset VM: #{e.message}"
    end

    private

    def find_compute_resource
      @compute_resource = ComputeResource.find(params[:compute_resource_id])
    end

    def find_vm
      manager = ForemanHyperv::VMManager.new(
        ForemanHyperv::CommandRunner.new(@compute_resource.hyperv_client)
      )

      @vm = manager.find_vm(params[:vm_id])
    end

  end
end