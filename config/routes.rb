Rails.application.routes.draw do
  namespace :foreman_hyperv do
    post 'start_vm/:compute_resource_id/:vm_id',
         to: 'compute_resources_vms#start',
         as: :start_vm
    
    post 'stop_vm/:compute_resource_id/:vm_id',
         to: 'compute_resources_vms#stop',
         as: :stop_vm

    post 'reboot_vm/:compute_resource_id/:vm_id',
         to: 'compute_resources_vms#reboot',
         as: :reboot_vm

    post 'reset_vm/:compute_resource_id/:vm_id',
         to: 'compute_resources_vms#reset',
         as: :reset_vm
  end
end