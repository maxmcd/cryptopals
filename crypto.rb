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
end