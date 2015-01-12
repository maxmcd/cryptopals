class Crypto
    require 'openssl'
    require 'base64'

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

    def self.string_xor(first_string, second_string)
        Crypto.hex_decode(
            Crypto.hex_xor(
                Crypto.hex_encode(first_string), 
                Crypto.hex_encode(second_string)
            )
        )
    end

    def self.hex_decode(string)
        [string].pack('H*')
    end

    def self.hex_encode(string)
        string.unpack('H*').first
    end

    def self.base64_decode(string)
        return Base64.decode64(string)
    end

    def self.base64_encode(string)
        return Base64.encode64(string)
    end

    def self.all_characters
        # return ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a + [' ', ',',':']
        return (0...128).map{ |i| [i.to_s(16).rjust(2, '0')].pack('H*')}
    end

    def self.hamming_distance(a, b)
        if a.length != b.length
            raise "Incompatible Hamming Distance"
        end
        ua = a.unpack('b*').join
        ub = b.unpack('b*').join
        diff = 0
        ua.length.times { |n|  diff += 1 if ua[n] != ub[n] }
        return diff
    end

    def self.solve_for_single_char_xor(string)
        # assume string is utf8?
        highest_score = 0
        best_string, best_key, best_output = nil, nil, nil
        Crypto.all_characters.each do |character|
            output = ""
            string.chars.each do |string_char|
                hex_char = character.unpack('H*').first
                hex_schar = string_char.unpack('H*').first
                output = output + Crypto.hex_decode(Crypto.hex_xor(hex_char, hex_schar))
            end
            score = output.scan(/[ETAOIN SHRDLU]/i).size
            if score > highest_score
                highest_score = score
                best_key = character
                best_output = output
            end
        end

        # puts    "The key is likely #{best_key} it had the score " + 
                # "#{highest_score} and the output was \"#{}\""
        return best_key
    end

    def self.AES_128_ECB_dec(data, key)
        cipher = OpenSSL::Cipher.new 'AES-128-ECB'
        cipher.decrypt
        cipher.padding = 0
        cipher.key = key
        return cipher.update(data) + cipher.final
    end

    def self.AES_128_ECB_enc(data, key)
        cipher = OpenSSL::Cipher.new 'AES-128-ECB'
        cipher.encrypt
        cipher.key = key
        return cipher.update(data)# + cipher.final
    end

    def self.AES_128_CBC_dec(data, key, iv)
        result = ""
        previous_block = iv
        key_length = key.length
        data.bytes.each_slice(key_length) do |block|
            block = block.map{|a| a.chr }.join
            value = Crypto.AES_128_ECB_dec(block, key)
            result += Crypto.string_xor(previous_block, value)
            previous_block = block
        end
        result
    end

    def self.AES_128_CBC_enc(data, key, iv)
        key_length = key.length
        result = ""
        previous_block = iv
        data.bytes.each_slice(key_length) do |block|
            block = block.map{|a| a.chr }.join
            value = Crypto.string_xor(block, previous_block)
            encrypted_block = Crypto.AES_128_ECB_enc(value, key)
            result += encrypted_block
            previous_block = encrypted_block
        end
        result
    end

    def self.random_AES_key(length)
        return Random.new.bytes(length)
    end

    def self.PKCS7(string, length)
        padding_length = length - string.length

        # if there is no padding, append a new padding block
        # of the same size
        padding_length = length if padding_length == 0            
        
        padding_character = padding_length.chr
        string + (padding_character * padding_length)
    end 
end