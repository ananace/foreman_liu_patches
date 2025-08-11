# frozen_string_literal: true

module ForemanLiuPatches
  module DnsHandling
    def recreate_dns_record(type)
      # Upstream method will skip creation if the local DNS resolver thinks the entry still exists
      # This breaks both with local caching, as well as with the distributed InfoBlox resolvers
      # Since the entry _was_ removed if the code got here, just assume that it _needs_ to be created again
      return true if dns_record(type).nil?

      set_dns_record(type)
    end

    def boot_server
      return unless tftp?

      # If the subnet DHCP server doesn't want hostnames, always store it as an IPv4 address
      unless subnet.dhcp.has_capability?(:DHCP, :dhcp_filename_hostname)
        res = Resolv::DNS.open { |dns| dns.getaddresses(boot_server_or_proxy_hostname) }.select { |addr| addr.is_a? Resolv::IPv4 }.first
        return res.to_s if res
      end

      super
    end    
  end
end
