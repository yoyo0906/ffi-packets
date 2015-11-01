# Address resolution Protocol

module FFI::Packets
  module Arp
    # ARP header
    # 
    #   field :hrd, :uint16, :desc => 'format of hardware address'
    #   field :pro, :uint16, :desc => 'format of protocol address'
    #   field :hln, :uint16, :desc => 'length of hw address (ETH_ADDR_LEN)'
    #   field :pln, :uint16, :desc => 'length of proto address (IP_ADDR_LEN)'
    #   field :op,  :uint16, :desc => 'operation'
    #
    class Hdr < AutoStruct
      
      dsl_layout do
        field :hrd, :uint16, :desc => 'format of hardware address'
        field :pro, :uint16, :desc => 'format of protocol address'
        field :hln, :uint8,  :desc => 'length of hw address (ETH_ADDR_LEN)'
        field :pln, :uint8, :desc => 'length of proto address (IP_ADDR_LEN)'
        field :op,  :uint16, :desc => 'operation'
      end

      # ARP operations
      module Op
        Constants.constants.grep(/^(ARP_OP_([A-Z][A-Z0-9_]+))$/) do
          self.const_set $2, Constants.const_get($1)
        end

        module_function
        def list
          @@list ||= constants.inject({}){|h,c| h.merge! c => const_get(c) }
        end
      end # Op
    end # Hdr

    # Ethernet/IP ARP message
    #
    #   array :sha, [:uint8, ETH_ADDR_LEN], :desc => 'sender hardware address'
    #   array :spa, [:uint8, IP_ADDR_LEN],  :desc => 'sender protocol address'
    #   array :tha, [:uint8, ETH_ADDR_LEN], :desc => 'target hardware address'
    #   array :tpa, [:uint8, IP_ADDR_LEN],  :desc => 'target protocol address'
    #
    class Ethip < AutoStruct
      eth_addr_len = ETH_ADDR_LEN = Constants::ETH_ADDR_LEN
      ip_addr_len = IP_ADDR_LEN = Constants::IP_ADDR_LEN

      dsl_layout do
        array :sha, [:uint8, eth_addr_len], :desc => 'sender hardware address'
        array :spa, [:uint8, ip_addr_len],  :desc => 'sender protocol address'
        array :tha, [:uint8, eth_addr_len], :desc => 'target hardware address'
        array :tpa, [:uint8, ip_addr_len],  :desc => 'target protocol address'
      end

    end # Ethip

  end # module Arp

end
