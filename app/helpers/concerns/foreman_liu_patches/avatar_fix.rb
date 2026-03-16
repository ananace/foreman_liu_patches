# frozen_string_literal: true

module ForemanLiuPatches
  module AvatarFix
    def avatar_image_tag(user, html_options = {})
      return super unless user.avatar_hash.present?

      image_tag("avatars/#{user.avatar_hash}.jpg", skip_pipeline: true, **html_options)
    end
  end
end
