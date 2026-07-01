# frozen_string_literal: true

module ForemanLiuPatches
  module RoaminghostHost
    def set_interface(attributes, _, _)
      if roaminghost?
        attributes[:ipaddress] = '0.0.0.0'
        attributes[:ipaddress6] = nil
        attributes[:keep_subnet] = true
      end

      super
    end

    private

    def roaminghost?
      return false if self.is_a?(Host::Discovered)

      subnet&.network == '0.0.0.0' || subnet6&.network == 'fe80::'
    end
  end
end
