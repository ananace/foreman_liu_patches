# frozen_string_literal: true

module ForemanLiuPatches
  # Ensure that FreeBSD allows booting UEFI
  # Our mfsbsd has been prepared for it
  module FreebsdPxeLoaders
    def available_loaders
      self.class.all_loaders
    end
  end
end
