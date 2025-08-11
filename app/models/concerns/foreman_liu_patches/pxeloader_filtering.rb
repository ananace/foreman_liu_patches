# frozen_string_literal: true

module ForemanLiuPatches
  # Trim the list of available PXE loaders to only contain the ones that we support
  module PxeloaderFiltering
    def all_loaders
      super & [
        'None',
        'PXELinux BIOS',
        'Grub2 UEFI',
        'Grub2 UEFI SecureBoot',
        'iPXE Embedded',
        'iPXE Chain BIOS',
        'iPXE Chain UEFI'
      ]
    end
  end
end
