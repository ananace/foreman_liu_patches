# frozen_string_literal: true

module ForemanLiuPatches
  module RoaminghostNic
    def dns?
      return false if roaminghost?

      super
    end

    def reverse_dns?
      return false if roaminghost?

      super
    end

    def dns6?
      return false if roaminghost6?

      super
    end

    def reverse_dns6?
      return false if roaminghost6?

      super
    end

    def dhcp_attrs(_)
      dhcp_attrs = super

      dhcp_attrs.merge!(ip: '0.0.0.0') if roaminghost?

      dhcp_attrs
    end

    private

    def roaminghost?
      subnet&.network == '0.0.0.0' || ip == '0.0.0.0'
    end

    def roaminghost6?
      subnet6&.network == 'fe80::' || ip6 == 'fe80::' 
    end
  end
end
