require 'ffi/packets/mac_addr'

module FFI::Packets
  # Linux cooked-mode capture
  class Sll < AutoStruct
    dsl_layout do
      field  :ptype, :ushort, :desc => 'packet type'
      field  :atype, :ushort, :desc => 'link-layer address type'
      field  :alen,  :ushort, :desc => 'link-layer address length'
      struct :src,   FFI::Packets::MacAddr, :desc => 'source address'
      field  :pad,   :ushort, :desc => 'padding'
      field  :etype, :ushort, :desc => 'ethernet payload type'
    end
  end
end

