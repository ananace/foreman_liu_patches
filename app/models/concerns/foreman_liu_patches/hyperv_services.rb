# frozen_string_literal: true

module ForemanLiuPatches
  # Modify default list of integration services to match LiU defaults
  module HypervServices
    def create_vm(attr = {})
      vm = super

      vm.service.disable_vm_integration_service(
        computer_name: vm.computer_name, vm_id: vm.id, name: 'Time Synchronization'
      )
      vm.service.enable_vm_integration_service(
        computer_name: vm.computer_name, vm_id: vm.id, name: 'Guest Service Interface'
      )

      vm
    end
  end
end
