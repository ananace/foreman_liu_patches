# frozen_string_literal: true

module ForemanLiuPatches
  class Engine < ::Rails::Engine
    engine_name 'foreman_liu_patches'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/services/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/validators/concerns"]

    initializer 'foreman_liu_patches.load_app_instance_data' do |app|
      ForemanLiuPatches::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_liu_patches.register_plugin', before: :finisher_hook do |app|
      app.reloader.to_prepare do
        Foreman::Plugin.register :foreman_liu_patches do
          requires_foreman '>= 3.12'
        end
      end
    end

    # TODO: Partial load based on settings file
    config.to_prepare do
      # Handle roaming hosts, keep first in list to ensure execution order
      ::Host::Base.prepend ForemanLiuPatches::RoaminghostHost
      ::Nic::Managed.prepend ForemanLiuPatches::RoaminghostNic
      # Clear certname on rebuild, to ensure certname and hostname are in sync
      ::Host::Managed.prepend ForemanLiuPatches::ClearCertnameOnBuild
      # Limit Windows hostname length to integrate better with AD
      ::Host::Managed.prepend ForemanLiuPatches::WindowsHostnameLimit
      # Filter list of acceptable PXE loaders to those available at LiU
      ::Operatingsystem.extend ForemanLiuPatches::PxeloaderFiltering
      # Expand FreeBSD PXE loader list to match our local setup
      ::Freebsd.prepend ForemanLiuPatches::FreebsdPxeLoaders
      # Allow the use of our "No IPv6" subnet at all time
      ::SubnetsConsistencyValidator.prepend ForemanLiuPatches::NoIpv6Validation
      # Foreman is source-of-truth for interface addresses
      ::Nic::Managed.prepend ForemanLiuPatches::KeepInterfaceAddress
      # Modify handling of DNS entries to work better with InfoBlox
      ::Nic::Managed.prepend ForemanLiuPatches::DnsHandling
      # Render LiU-forked snippets if available
      ::Foreman::Renderer::Scope::Macros::SnippetRendering.prepend ForemanLiuPatches::ForkedSnippets
    rescue StandardError => e
      Rails.logger.warn "ForemanLiuPatches: skipping engine hook(#{e})"
    end
  end
end
