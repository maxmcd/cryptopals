require_relative 'crypto'


# 2.9
puts "Challenge 9"
puts Crypto.PKCS7("YELLOW SUBMARINE", 20)



# 2.10
puts "\nChallenge 10"

# test encoding
data = File.read('7.txt');
data = Crypto.base64_decode(data)
message = Crypto.AES_128_ECB_dec(data, "YELLOW SUBMARINE")
puts 'Does AES-128-ECB encoding work?'
puts data == Crypto.AES_128_ECB_enc(message, "YELLOW SUBMARINE")

f = File.read('10.txt')
f = Crypto.base64_decode(f)
iv = "\x00" * 16

lyrics = Crypto.AES_128_CBC_dec(f, "YELLOW SUBMARINE", iv)

f = Crypto.AES_128_CBC_enc(lyrics, "YELLOW SUBMARINE", iv)

Crypto.AES_128_CBC_dec(f, "YELLOW SUBMARINE", iv)


# 2.11

def random_encrypt(data)
    random_aes_key = Crypto.random_AES_key(16)
    padding_before = 0.chr * (Random.new.rand(6) + 5)
    padding_after = 0.chr * (Random.new.rand(6) + 5)
    data = padding_before + data + padding_after
    if Random.new.rand(2) == 1
        puts "CBC"
        return Crypto.AES_128_CBC_enc(data, random_aes_key, Random.new.bytes(16))
    else
        puts "ECB"
        return Crypto.AES_128_ECB_enc(data, random_aes_key)
    end
end


string = random_encrypt(
    "111111111111111111111111111111111111111111111111
     111111111111111111111111111111111111111111111111
     111111111111111111111111111111111111111111111111
     111111111111111111111111111111111111111111111
    "
)

hash = Hash.new(0)
string.scan(/.{16}/).each do |sixteen_byte_chunk|
    hash[sixteen_byte_chunk] += 1
end
is_ecb = false
hash.each do |a, b| 
    if b > 1
        is_ecb = true
    end
end
puts (is_ecb ? "ECB" : "CBC")

