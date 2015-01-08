require_relative 'crypto'


# 1.1
# convert hex to base64

hex_string = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
solution = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

puts "Challenge 1.1 is solved?"
puts Crypto.hex_to_base64(hex_string) == solution

# 1.2
#Fixed XOR
#Write a function that takes two equal-length buffers and produces their XOR combination.

first_string = "1c0111001f010100061a024b53535009181c"
second_string = "686974207468652062756c6c277320657965"

solution = "746865206b696420646f6e277420706c6179"

puts "Challenge 1.2 is solved?"
puts Crypto.hex_xor(first_string, second_string) == solution


# 1.3
# Single-byte XOR cipher
# The hex encoded string: 
# 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736 
# has been XOR'd against a single character. Find the key, decrypt the message.


string = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

characters.each do |character|
    output =  ""
    string.scan(/../).each do |hex_char|
        hex = character.unpack('H*').first
        output = output + hex_decode(hex_xor(hex, hex_char))
    end
    score = 0
    possible_words = output.split(' ')
    possible_words.each do |word|
        if words[word.downcase]
            score = score + 1
        end
    end
    # if score > 1
        # puts score
        puts character
        puts output
    # end
end


def calculate_character_frequency(string)

end

# scores = calculate_character_frequency(all_words)
$score_key = 

test_sentence = "Like free cupcakes? Join me in ~45 minutes when I get into Hacker School on a trip to Georgetown Cupcakes (which gives away free cupcakes every day). Today's flavor is Vanilla Sunshine. Also planning to get a Cookies & Cream Cheesecase "
crypto_string = "ec58ea200e3005090e1725005739eda7342aed311001383fff7c58ef1f11
01305424231c0d2c41f105057f74510d335440332f1038ec17275f5814e1
05f12f380720ea2b19e24a07e53c142128354e2827f25a08fb401c3126a6
0d17272f53063954163d050a541b1f1144305ae37d4932431b1f33140b1b
0b4f070f071fe92c200e1fa05e4b272e50201b5d493110e429482c100730
100a3148080f227fe60a132f0c10174fe3f63d1a5d38eb414ca8e82f2b05
0a19e83c58400a023b13234572e6e4272bf67434331631e63b5e0f00175c
54520c2ceb45530e0f78111d0b0707e01e4bf43b0606073854324421e6f9
09e7585353ee4a34190de1354e481c373a1b2b0a136127383e271212191f
0f060d09fb4f2d5024022c5ff6463c390c2b5f1a5532071a31f33503fcea
371d39121605584f48217235ee1e0602445c162e4942254c071954321d29
4a0900e63e5f161e15554045f3594c2a6a77e4e52711602beaf53ae53bed
29011616565d2a372a605bee39eced31183fe068185c3b445b391fe53232
e4102337000303452a1e2f2b29493f54ed5a037b3e08311b625cfd005009
2d560d4b0618203249312a310d5f541f295c3f0f25235c2b20037d1600f3
2c245155e8253708391a7ceb0d05005c3e080f3f0f0e5a16583b111f4448
493804044d262eec3759594f212d562420105d6a39e70a0f3957f347070c
e72d1d1f103807590f4339575e00381074485d2d580249f744052605e11d
e131570ae95307143a71131729552d001057a4540a1f425b190b572dee34
2c1655342f02581c202b0a5c17a358291e1506f325550f05365e165c1c5f
e318164df80b043e5406296e5359271d152f552e155a43eda81f23231d1c
001de0413e174e18192c061e4b3d1b5626f90e3e1429544a20ee150d0c20"

def character_frequency_difference(test_scores)
    total_difference = 0
    test_scores.each do |key, value|
        total_difference += ($score_key[key] - value)
    end
    return total_difference
end

# 1.4
# Detect single-character XOR
# One of the 60-character strings in this file has been encrypted by single-character XOR.
# Find it.

encoded_strings = []
File.open("4.txt") do |file|
    file.each do |line|
        encoded_strings << line.strip
    end
end

=begin
    encoded_strings.each do |string|
        characters.each do |character|
            output =  ""
            string.scan(/../).each do |hex_char|
                hex = character.unpack('H*').first
                output = output + hex_decode(hex_xor(hex, hex_char))
            end
            score = 0
            possible_words = output.split(' ')
            possible_words.each do |word|
                if words[word]
                    score = score + 1
                end
            end
            if score > 2
                puts character
                puts output
                puts string
            end
        end
    end
=end

# 1.5

stanza = 
    "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"

key = 'ICE'
keystring = 'ICE' * (stanza.length/2) #ehhhhhhhhh
# a cycle function has to fit in here somehow

solution = ""
stanza.split('').each_with_index do |char, i|
    char_hex = char.unpack('H*').first
    key_char_hex = keystring[i].unpack('H*').first
    solution = solution + hex_xor(char_hex, key_char_hex)
end
# p solution

f = File.read('6.txt');
$data = f.unpack('m').join;

puts $data

def hamming_distance(a, b)
    if a.length != b.length
        raise "Incompatible Hamming Distance";
    end
    ua = a.unpack('b*').join;
    ub = b.unpack('b*').join;
    diff = 0;
    ua.length.times { |n|  diff += 1 if ua[n] != ub[n] }
    return diff;
end

def data_edit_difference(key_size)
    chunk_count = $data.length/(key_size*2)
    distances = []
    chunk_count.times do |i|
        offset = i
        chunk1 = $data[offset..((key_size-1)+offset)]
        chunk2 = $data[offset+key_size..(offset + (key_size*2)-1)]
        distances << hamming_distance(chunk1, chunk2)/(key_size*1.0)
    end
    distances.inject{ |sum, el| sum + el }.to_f / distances.size #average of all distances
end

array = []
39.times do |i|
    array << [i+2, data_edit_difference(i+2)]
end

array = array.sort{|a, b| a[1] <=> b[1]}

array.each do |bit_length, hamming_distance|
    puts "#{bit_length} - #{hamming_distance}"
end
