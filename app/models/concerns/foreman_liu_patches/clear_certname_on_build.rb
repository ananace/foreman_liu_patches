# frozen_string_literal: true

module ForemanLiuPatches
  # Clear old certnames on host rebuild
  # The certname will automatically be repopulated with the current hostname on next access
  module ClearCertnameOnBuild
    def clear_certname
      self.certname = nil
    end

    def clear_data_on_build
      super

      clear_certname
    end
  end
end
