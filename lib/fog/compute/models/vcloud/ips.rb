require 'fog/compute/models/vcloud/ip'

module Fog
  module Vcloud
    class Compute
      class Ips < Fog::Vcloud::Collection

        model Fog::Vcloud::Compute::Ip

        undef_method :create

        attribute :href

        def all
          self.href = connection.default_vdc_href unless self.href
          check_href!( :messages => "Ips href of a Network you want to enumerate" )
          if data = connection.get_network_ips(href).body[:IpAddress]
            load(data)
          end
        end

        def get(uri)
          if data = connection.get_network_ip(uri).body
            new(data)
          end
        rescue Fog::Errors::NotFound
          nil
        end

      end
    end
  end
end
