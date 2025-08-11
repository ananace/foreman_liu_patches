# frozen_string_literal: true

module ForemanLiuPatches
  module KeepInterfaceAddress
    def set_interface(attributes, _, iface)
      attributes[:ipaddress] = iface.ip if iface.ip
      attributes[:ipaddress6] = iface.ip6 if iface.ip6
      attributes[:keep_subnet] = true if iface.subnet || iface.subnet6

      super
    end
  end
end
