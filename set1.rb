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

puts "\nChallenge 1.2 is solved?"
puts Crypto.hex_xor(first_string, second_string) == solution


# 1.3
# Single-byte XOR cipher
# The hex encoded string: 
# 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736 
# has been XOR'd against a single character. Find the key, decrypt the message.


puts "\nChallenge 1.3"

string = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

highest_score = 0 #artifically high
best_string, best_key, best_output = nil, nil, nil

puts "Testing all characters"
Crypto.all_characters.each do |character|
    output =  ""
    string.scan(/../).each do |hex_char|
        hex = character.unpack('H*').first
        output = output + Crypto.hex_decode(Crypto.hex_xor(hex, hex_char))
    end
    score = output.scan(/[ETAOIN SHRDLU]/i).size
    if score > highest_score
        highest_score = score
        best_key = character
        best_output = output
    end
end

puts    "The key is likely #{best_key} it had the score " + 
        "#{highest_score} and the output was \"#{best_output}\""


# 1.4
# Detect single-character XOR
# One of the 60-character strings in this file has been encrypted by single-character XOR.
# Find it.

puts "\nChallenge 1.4"

encoded_strings = []
File.open("4.txt") do |file|
    file.each do |line|
        encoded_strings << line.strip
    end
end


highest_score = 0 #artifically high

puts "Testing all strings for all characters"

=begin
encoded_strings.each do |string|
    Crypto.all_characters.each do |character|
        output =  ""
        string.scan(/../).each do |hex_char|
            hex = character.unpack('H*').first
            output = output + Crypto.hex_decode(Crypto.hex_xor(hex, hex_char))
        end
        score = output.scan(/[ETAOIN SHRDLU]/i).size
        
        # puts output
        if score > highest_score
            highest_score = score
            best_key = character
            best_output = output
        end
    end

    # highest_score = 0
end

puts    "The string is likely #{best_string}. The key is likely " + 
        "#{best_key} it had the score " + 
        "#{highest_score} and the output was \"#{best_output}\""
=end

# # 1.5

puts "\nChallenge 1.5"
stanza = 
    "Burning 'em, if you ain't quick and nimble\n" + "I go crazy when I hear a cymbal"

key = 'ICE'
keystring = 'ICE' * (stanza.length/2) #ehhhhhhhhh
# a cycle function has to fit in here somehow

solution = ""
stanza.split('').each_with_index do |char, i|
    char_hex = char.unpack('H*').first
    # puts char_hex
    key_char_hex = keystring[i].unpack('H*').first
    solution = solution + Crypto.hex_xor(char_hex, key_char_hex)
end

puts "Is it solved?"
puts "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272" + 
"a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f" == solution
# p solution

f = File.read('6.txt');
$data = f.unpack('m').join;

# puts $data

def data_edit_difference(key_size)
    chunk_count = $data.length/(key_size*2)
    distances = []
    chunk_count.times do |i|
        offset = i
        chunk1 = $data[offset..((key_size-1)+offset)]
        chunk2 = $data[offset+key_size..(offset + (key_size*2)-1)]
        distances << Crypto.hamming_distance(chunk1, chunk2)/(key_size*1.0)
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
