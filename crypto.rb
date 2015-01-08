class Crypto

    def self.hex_to_base64(hex_string)
        # http://apidock.com/ruby/Array/pack
        return [[hex_string].pack("H*")].pack("m0")
    end

    def self.base64_to_hex(base64_string)
        return base64_string.unpack("m0").first.unpack("H*").first
    end

    def self.hex_xor(first_string, second_string)
        (first_string.to_i(16) ^ second_string.to_i(16)).to_s(16).rjust(first_string.length, '0')
    end

    def self.hex_decode(string)
        [string].pack('H*')
    end

    def self.hex_encode(string)
        string.unpack('H*')
    end

    def self.all_characters
        return ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a
    end


end