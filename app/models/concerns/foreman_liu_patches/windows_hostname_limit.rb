# frozen_string_literal: true

module ForemanLiuPatches
  # Ensure that Windows machine names are 15 characters or less
  # This is to allow AD joins
  module WindowsHostnameLimit
    extend ActiveSupport::Concern

    prepended do
      validate :netbios_name, if: -> { managed? && operatingsystem.type == 'Windows' }
    end

    def netbios_name
      return unless shortname && shortname.size > 15

      errors.add(:name, 'Windows needs a hostname with <= 15 characters.')
    end
  end
end
