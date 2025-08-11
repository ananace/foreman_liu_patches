# frozen_string_literal: true

module ForemanLiuPatches
  # LiU uses a specific subnet for "No IPv6" to avoid inheritance issues
  # This subnet should always be considered as valid
  module NoIpv6Validation
    def validate_vlanid(record)
      return if record.subnet6.id == 121

      super
    end
  end
end
