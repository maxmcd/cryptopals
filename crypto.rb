class Crypto

    def self.hex_to_base64(hex_string)
        # http://apidock.com/ruby/Array/pack
        return [[hex_string].pack("H*")].pack("m0")
    end

    def self.base64_to_hex(base64_string)
        return base64_string.unpack("m0").first.unpack("H*").first
    end

    def self.hex_xor(first_string, second_string)
        (first_string.to_i(16) ^ second_string.to_i(16)).to_s(16)
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

    def self.all_words_hash
        words = {}
        File.open("/usr/share/dict/words") do |file|
          file.each do |line|
            words[line.strip] = true
          end
        end
        return words
    end

    def self.calculate_character_frequency(string)
        string = string.gsub(/\s+/, "") #clear whitespace
        
        character_array = string.split('')

        character_count = character_array.length
    
        character_count_obj = {}
        character_array.each do |character|
            if character_count_obj[character]
                character_count_obj[character] += 1
            else
                character_count_obj[character] = 1
            end
        end
        scores = {}
        character_count_obj.each do |key, count|
            scores[key] = count.to_f/character_count
        end
        scores
    end

    def self.english_language_character_frequency
        # calculated using this:
        # f = File.read('big.txt'); #http://norvig.com/big.txt
        # all_words = f.to_s;
        # calculate_character_frequency(all_words)
        {"T"=>0.00396352445122468, "h"=>0.0506849097381134, "e"=>0.11800721989151623, "P"=>0.0013428044749555048, "r"=>0.058484167090431395, "o"=>0.07272862106958217, "j"=>0.0007435746673446902, "c"=>0.025883417026866685, "t"=>0.08586731396728536, "G"=>0.0007885996694635139, "u"=>0.024435333502839225, "n"=>0.06856380837359098, "b"=>0.011696568565132638, "g"=>0.0163871143740995, "E"=>0.0017731905246207305, "B"=>0.0011646908636325113, "k"=>0.004768677430290702, "f"=>0.02252375730994152, "A"=>0.002911396092889228, "d"=>0.03742703301127214, "v"=>0.00935659271972201, "s"=>0.05771940418679549, "S"=>0.002692892406136113, "l"=>0.03575051381473006, "H"=>0.0018685375879311807, "m"=>0.022058278243918976, "y"=>0.015790533096025086, "i"=>0.06367329858462581, "C"=>0.0021698078226968388, "a"=>0.07307160564454615, "D"=>0.0009124184252902788, "("=>0.00026882574794474107, "#"=>1.9863971523010423e-06, "1"=>0.0018976714128315958, "5"=>0.0005522184083396898, ")"=>0.00026816361556064074, "p"=>0.01775706627680312, "w"=>0.017667678404949573, "."=>0.0118170766590389, "\""=>0.005057367149758454, ","=>0.014133877871006017, "I"=>0.004645520806848038, "Y"=>0.0005846628951606068, "*"=>5.2970590728027796e-05, "W"=>0.0017089636833629968, "F"=>0.0010203460038986354, "V"=>0.00045687134502923974, "x"=>0.0015533625730994151, "R"=>0.0014090177133655394, "9"=>0.0006661051784049496, "7"=>0.0006654430460208492, "!"=>0.00026816361556064074, ":"=>0.0002794198660903466, "M"=>0.0015123103652851936, "["=>0.00012779155013136707, "6"=>0.0006336606915840325, "]"=>0.00012779155013136707, "N"=>0.001579847868463429, "2"=>0.0007859511399271124, "0"=>0.001107085346215781, "L"=>0.000987239384693618, "O"=>0.0012011081447580304, "J"=>0.0005595018645647937, "U"=>0.0006171073819815239, "K"=>0.00022115221628951607, "z"=>0.0005965812780744131, "-"=>0.0036192156114924993, "X"=>7.614522417153996e-05, "'"=>0.0013355210187304008, "q"=>0.0007780055513179083, "8"=>0.000987239384693618, ";"=>0.0008773254089329604, "?"=>0.000670740105093652, "Q"=>6.555110602593441e-05, "&"=>3.9727943046020846e-06, "$"=>6.952390033053649e-05, "4"=>0.0005700959827103992, "3"=>0.00059062208661751, "Z"=>1.853970675480973e-05, "/"=>1.7215441986609035e-05, "+"=>2.1850368675311467e-05, "%"=>1.9863971523010423e-06, "<"=>6.621323841003475e-07, "@"=>1.324264768200695e-06, ">"=>6.621323841003475e-07, "~"=>6.621323841003475e-07, "_"=>0.0009541327654886007, "="=>0.0011534346131028053, "^"=>6.621323841003475e-07, "|"=>0.00019003199423679973}
    end

    def self.character_frequency_difference(test_scores)
        # a few test strings
        # test_sentence = "Like free cupcakes? Join me in ~45 minutes when I get into Hacker School on a trip to Georgetown Cupcakes (which gives away free cupcakes every day). Today's flavor is Vanilla Sunshine. Also planning to get a Cookies & Cream Cheesecase "
        # crypto_string = "ec58ea200e3005090e1725005739eda7342aed311001383fff7c58ef1f1101305424231c0d2c41f105057f74510d335440332f1038ec17275f5814e105f12f380720ea2b19e24a07e53c142128354e2827f25a08fb401c3126a60d17272f53063954163d050a541b1f1144305ae37d4932431b1f33140b1b0b4f070f071fe92c200e1fa05e4b272e50201b5d493110e429482c100730100a3148080f227fe60a132f0c10174fe3f63d1a5d38eb414ca8e82f2b050a19e83c58400a023b13234572e6e4272bf67434331631e63b5e0f00175c54520c2ceb45530e0f78111d0b0707e01e4bf43b0606073854324421e6f909e7585353ee4a34190de1354e481c373a1b2b0a136127383e271212191f0f060d09fb4f2d5024022c5ff6463c390c2b5f1a5532071a31f33503fcea371d39121605584f48217235ee1e0602445c162e4942254c071954321d294a0900e63e5f161e15554045f3594c2a6a77e4e52711602beaf53ae53bed29011616565d2a372a605bee39eced31183fe068185c3b445b391fe53232e4102337000303452a1e2f2b29493f54ed5a037b3e08311b625cfd0050092d560d4b0618203249312a310d5f541f295c3f0f25235c2b20037d1600f32c245155e8253708391a7ceb0d05005c3e080f3f0f0e5a16583b111f4448493804044d262eec3759594f212d562420105d6a39e70a0f3957f347070ce72d1d1f103807590f4339575e00381074485d2d580249f744052605e11de131570ae95307143a71131729552d001057a4540a1f425b190b572dee342c1655342f02581c202b0a5c17a358291e1506f325550f05365e165c1c5fe318164df80b043e5406296e5359271d152f552e155a43eda81f23231d1c001de0413e174e18192c061e4b3d1b5626f90e3e1429544a20ee150d0c20"

        total_difference = 0
        test_scores.each do |key, value|
            total_difference += (
                if self.english_language_character_frequency[key]
                    (self.english_language_character_frequency[key] - value).abs
                else
                    0
                end
            )
        end
        return total_difference
    end


end