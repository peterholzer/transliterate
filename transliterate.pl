#!/usr/bin/perl
# Ⓐ☭
use strict;
use warnings;
use Getopt::Long;

use utf8;
use open ':std', ':encoding(UTF-8)';



my %options = ();
GetOptions(\%options,
            'output|o=s',
            'en|e',
            'de|d',
          # 'sci|s',
            'help|h',
            'manual|m',
            'verbose|v');

while( my $line = <>)
{
    print "\e[37m" . $line . "\e[0m";
    if($options {'de'})
    {
        $line = transliterate_russ_de($line );
    }
    else
    {
        $line = transliterate_russ_en($line );
    }
    $line = transliterate_ancientgreek($line );
    $line = transliterate_bangla($line );
    print $line;
    print "\n";
}


print "\n";

exit 0;



sub transliterate_ancientgreek
{
    my $line = $_[0];

    my %characters = (

        'Α' => "A",     'α' => "a",                       # alpha
        'Ά' => "A",     'ά' => "a",                       # alpha with tonos
        # ἀ
        'Β' => "B",     'β' => "b",                       # beta
                        'ϐ' => "b",
        'Γ' => "G",     'γ' => "g",                       # gamma
        'Δ' => "D",     'δ' => "d",                       # delta
        'Ε' => "E",     'ε' => "e",                       # epsilon
                        'ϵ' => "e",
        'Έ' => "E",     'έ' => "e",                       # epsilon with tonos
        'Ζ' => "Z",     'ζ' => "z",                       # zeta
        'Η' => "ē",     'η' => "ē",                       # eta
        'Ή' => "ē",     'ή' => "ē",                       # eta with tonos
        'Θ' => "Th",    'θ' => "th",                      # theta
                        'ϑ' => "th",
        'Ι' => "I",     'ι' => "i",                       # iota
        'Ί' => "I",     'ί' => "i",                       # iota with tonos
        'Ϊ' => "I",     'ϊ' => "i",                       # iota with dialytika
                        'ΐ' => "i",                       # iota with dialytika and tonos
        'Κ' => "K",     'κ' => "k",                       # kappa
                        'ϰ' => "k",
        'Λ' => "L",     'λ' => "l",                       # lambda
        'Μ' => "M",     'μ' => "m",                       # mu
        'Ν' => "N",     'ν' => "n",                       # nu
        'Ξ' => "X",     'ξ' => "x",                       # xi
        'Ο' => "O",     'ο' => "o",                       # omicron
        'Ό' => "O",     'ό' => "o",                       # omicron with tonos
        'Π' => "P",     'π' => "p",                       # pi
                        'ϖ' => "p",
        'Ρ' => "R",     'ρ' => "r",  # (h)                # rho
                        'ϱ' => "r",
        'Σ' => "S",     'σ' => "s",                       # sigma
                        'ϲ' => "s",
                        'ς' => "s",                       # final sigma
        'Τ' => "T",     'τ' => "t",                       # tau
        'Υ' => "Y",     'υ' => "y", # bei αυ, ευ, ου: u   # upsilon
        'Ύ' => "Y",     'ύ' => "y",                       # upsilon with tonos
        'Ϋ' => "Y",     'ϋ' => "y",                       # upsilon with dialytika
                        'ΰ' => "y",                       # upsilon with dialytika and tonos
        'Φ' => "Ph",    'φ' => "ph",                      # phi
                        'ϕ' => "ph",
        'Χ' => "Ch",    'χ' => "ch",                      # chi
        'Ψ' => "Ps",    'ψ' => "ps",                      # psi
        'Ω' => "ō",     'ω' => "ō",                       # omega
        'Ώ' => "ō",     'ώ' => "ō",                       # omega with tonos


        'Ϝ' => "W", 'ϝ' => "w",   # Digamma (Wau)
        'Ͷ' => "W", 'ͷ' => "w",   # Digamma (Wau)
        'Ϛ' => "",  'ϛ' => "",    # Stigma
        'Ͱ' => "H", 'ͱ' => "h",   # Heta
        'Ϻ' => "S", 'ϻ' => "s",   # San
        'Ϙ' => "Q", 'ϙ' => "q",   # Koppa
        'Ϟ' => "Q", 'ϟ' => "q",   # Koppa
        'Ͳ' => "Ss", 'ͳ' => "ss", # Sampi
        'Ϡ' => "Ss", 'ϡ' => "ss", # Sampi


        '῾' => "", # Spiritus asper
        '᾽' => "", # Spiritus lenis

        '´' => "", # Akut,        Oxeia,       für den Hochton
        '`' => "", # Gravis,     Bareia,       für den Tiefton,
        '῀' => "", # Zirkumflex, Perispomenē,  für den Steig- und Fallton

        '¨' => "", # Trema
    );

    my $find_characters    =  join "|", keys %characters;

    $line =~ s/ь([ΑαΕεΟο])Υ/$characters{$1}U/g;
    $line =~ s/ь([ΑαΕεΟο])υ/$characters{$1}u/g;

    $line =~ s/($find_characters)/$characters{$1}/g;

    return $line;
}


sub transliterate_russ_de
{
    my $line = $_[0];

    my %vowels = (
        'А' => "A",       'а' => "a",
        'О' => "O",       'о' => "o",
        'У' => "U",       'у' => "u",
        'Э' => "E",       'э' => "e",
        'Ы' => "Y",       'ы' => "y",

        'Я' => "Ja",      'я' => "ja",
        'Ё' => "Jo",      'ё' => "jo",  # (o)  2)
        'Ю' => "Ju",      'ю' => "ju",
        'Е' => "E",       'е' => "e",   # (je) 1)
        'И' => "I",       'и' => "i",
    );
    my %consonants = (
        'Б' => "B",       'б' => "b",
        'В' => "W",       'в' => "w",
        'Г' => "G",       'г' => "g",   # (w)  8)
        'Д' => "D",       'д' => "d",
        'Ж' => "Sch",     'ж' => "sch",
        'З' => "S",       'з' => "s",
        'Й' => "I",       'й' => "i",   # (j)  4)
        'К' => "K",       'к' => "k",
        'Л' => "L",       'л' => "l",
        'М' => "M",       'м' => "m",
        'Н' => "N",       'н' => "n",
        'П' => "P",       'п' => "p",
        'Р' => "R",       'р' => "r",
        'С' => "S",       'с' => "s",   # (ss) 10)
        'Т' => "T",       'т' => "t",
        'Ф' => "F",       'ф' => "f",
        'Х' => "Ch",      'х' => "ch",
        'Ц' => "Z",       'ц' => "z",
        'Ч' => "Tsch",    'ч' => "tsch",
        'Ш' => "Sch",     'ш' => "sch",
        'Щ' => "Schtsch", 'щ' => "schtsch",
    );
    my %special_characters = (
        'Ъ' => "-",       'ъ' => "-",
        'Ь' => "'",       'ь' => "'",    # (j)  7)
    );
    # my $find_de    =  join "|", keys %replace_de;

    my $find_vowels             = join("|", keys %vowels);
    my $find_consonants         = join("|", keys %consonants);
    my $find_special_characters = join("|", keys %special_characters);


# Die Nummern beziehen sich auf die Anmerkungen hier: https://de.wikipedia.org/wiki/Kyrillisches_Alphabet#Russisch

# 7) Ь ь -> J j         (ьи,ье,ьо -> ji,je,jo_
    # Die Verbindungen ьи, ье und ьо werden als ji, je beziehungsweise jo transkribiert.
    $line =~ s/Ь([ИиЕеОо])/J$vowels{$1}/g;
    $line =~ s/ь([ИиЕеОо])/j$vowels{$1}/g;

# 1) Е е -> Je je
    # Nach russischen Vokalen, am Wortanfang und nach ь sowie ъ wird mit je beziehungsweise Je transkribiert,
    $line =~ s/($find_vowels)е/$1je/g;
    $line =~ s/($find_vowels)Е/$1JE/g;
    $line =~ s/\bЕ/Je/g;
    $line =~ s/\bе/je/g;
    $line =~ s/([ЪъЬь])е/$1je/g;

# 2) Ё ё -> O o
    # Ё ё wird nach ж (sch), ч (tsch), ш (sch), und щ (schtsch) mit o transkribiert.
    $line =~ s/([ЖжЧчШшЩщ])ё/$1o/g;
    $line =~ s/([ЖжЧчШшЩщ])Ё/$1O/g;

# 4) Й й
    # Duden: „й = i am Wortende sowie zwischen russischem Vokalbuchstaben und russischem Konsonantenbuchstaben“

    # Mit j wird й vor Vokal umschriftet
    # Й й -> J j vor Vokal
    $line =~ s/Й($find_vowels)/J$1/g;
    $line =~ s/й($find_vowels)/j$1/g;

    # й wird nach и und ы vor Konsonant mit j umschriftet.
    $line =~ s/([ИиЫы])й($find_consonants)/$1j$2/g;

    # й Duden: „й wird nach и und nach ы nicht wiedergegeben“
    $line =~ s/([ИиЫы])й/$1/g;

# 8) Г г -> w TODO TODO TODO
    # In der Genitivendung der Adjektive -ого/-его jedoch w: -owo/-(j)ewo.
    $line =~ s/\B([ео])го\b/$1wo/g;

# 10) С с -> ss
    # Zwischen Vokalen zur Kennzeichnung der stimmlosen Aussprache gewöhnlich ss.
    $line =~ s/($find_vowels)с($find_vowels)/$1ss$2/g;
    $line =~ s/($find_vowels)С($find_vowels)/$1SS$2/g;



    # $line =~ s/($find_de)/$replace_de{$1}/g;
    $line =~ s/($find_vowels)/$vowels{$1}/g;
    $line =~ s/($find_consonants)/$consonants{$1}/g;
    $line =~ s/($find_special_characters)/$special_characters{$1}/g;

    return $line;
}


sub transliterate_russ_en
{
    my $line = $_[0];

    my %characters = (
        'А' => "A",       'а' => "a",
        'Е' => "E",       'е' => "e",   # (ye) 1)
        'Ё' => "Jo",      'ё' => "jo",  # (yo) 2)
        'И' => "I",       'и' => "i",
        'О' => "O",       'о' => "o",
        'У' => "U",       'у' => "u",
        'Ы' => "Y",       'ы' => "y",
        'Э' => "E",       'э' => "e",
        'Ю' => "Yu",      'ю' => "yu",
        'Я' => "Ya",      'я' => "ya",

        'Б' => "B",       'б' => "b",
        'В' => "V",       'в' => "v",
        'Г' => "G",       'г' => "g",
        'Д' => "D",       'д' => "d",
        'Ж' => "Zh",      'ж' => "zh",
        'З' => "Z",       'з' => "z",
        'Й' => "Y",       'й' => "y",
        'К' => "K",       'к' => "k",
        'Л' => "L",       'л' => "l",
        'М' => "M",       'м' => "m",
        'Н' => "N",       'н' => "n",
        'П' => "P",       'п' => "p",
        'Р' => "R",       'р' => "r",
        'С' => "S",       'с' => "s",
        'Т' => "T",       'т' => "t",
        'Ф' => "F",       'ф' => "f",
        'Х' => "Kh",      'х' => "kh",
        'Ц' => "Ts",      'ц' => "ts",
        'Ч' => "Ch",      'ч' => "ch",
        'Ш' => "Sh",      'ш' => "sh",
        'Щ' => "Shch",    'щ' => "shch",

        'Ъ' => "-",       'ъ' => "-",
        'Ь' => "'",       'ь' => "'",    # (y)  7)
    );
    my $find_characters    =  join "|", keys %characters;

# 7) Ь ь -> Y y         (ьи,ье,ьо -> yi,ye,yo)
    $line =~ s/Ьи/Yi/g;
    $line =~ s/ьи/yi/g;
    $line =~ s/Ье/Ye/g;
    $line =~ s/ье/ye/g;
    $line =~ s/Ьо/Yo/g;
    $line =~ s/ьо/yo/g;

# 1) Е е -> Je je
    $line =~ s/([АаЕеЁёИиОоУуЫыЭэЮюЯя])е/$1ye/g;
    $line =~ s/([АаЕеЁёИиОоУуЫыЭэЮюЯя])Е/$1YE/g;
    $line =~ s/\bЕ/Ye/g;
    $line =~ s/\bе/ye/g;
    $line =~ s/([ЪъЬь])е/$1ye/g;

# 2) Ё ё -> O o
    $line =~ s/([ЖжЧчШшЩщ])ё/$1yo/g;
    $line =~ s/([ЖжЧчШшЩщ])Ё/$1YO/g;



    $line =~ s/($find_characters)/$characters{$1}/g;

    return $line;
}

# TODO: Letter য়ে
sub transliterate_bangla
{
    my $line = $_[0];

    my %vowels = (
        'অ' => "a",
        'আ' => "ā",
        'ই' => "i",
        'ঈ' => "ī",
        'উ' => "u",
        'ঊ' => "ū",
        'ঋ' => "ṛ",
        'এ' => "e",
        'ঐ' => "ai",
        'ও' => "o",
        'ঔ' => "au",
    );

    my %combining_vowels = (
        '্' => "",
        'া' => "ā",
        'ি' => "i",
        'ী' => "ī",
        'ু' => "u",
        'ূ' => "ū",
        'ৃ' => "ṛ",
        'ে' => "e",
        'ৈ' => "ai",
        'ো' => "o",
        'ৌ' => "au",
    );

    my %special_combinations = (
        'গু'  => "gu",
        'শু'  => "śu",
        'ন্তু' => "ntu",
        'স্তু' => "stu",
        'হু'  => "hu",
        'রু'  => "ru",
        'রূ'  => "rū",
        'হৃ'  => "hṛ",
    );

    my %special_characters = (
        'ৎ' => "t",
        'ং' => "ṁ", # Anusvara
        'ঃ' => "ḥ", # Visarga
        'ঁ' => "m̐", # Chandrabindu

        '০' => "0",
        '১' => "1",
        '২' => "2",
        '৩' => "3",
        '৪' => "4",
        '৫' => "5",
        '৬' => "6",
        '৭' => "7",
        '৮' => "8",
        '৯' => "9",

        '।' => ".",

        '৺' => "†",
    );

    my %consonants = (
        'ক' => "k",    'ধ' => "dh",
        'খ' => "kh",    'ন' => "n",
        'গ' => "g",     'প' => "p",
        'ঘ' => "gh",    'ফ' => "ph",
        'ঙ' => "ṅ",     'ব' => "b",
        'চ' => "c",     'ভ' => "bh",
        'ছ' => "ch",    'ম' => "m",
        'জ' => "j",    'য' => "y",
        'ঝ' => "jh",   'র' => "r",
        'ঞ' => "ñ",    'ল' => "l",
        'ট' => "ṭ",     'শ' => "ś",
        'ঠ' => "ṭh",    'ষ' => "ṣ",
        'ড' => "ḍ",     'স' => "s",
        'ঢ' => "ḍh",    'হ' => "h",
        'ণ' => "ṇ",     'য়' => "ẏ",
        'ত' => "t",    'ড়' => "ṛ",
        'থ' => "th",    'ঢ়' => "ṛh",
        'দ' => "d",
    );

    my $find_special_combinations = join("|", keys %special_combinations);
    my $find_consonants           = join("|", keys %consonants);
    my $find_combining_vowels     = join("|", keys %combining_vowels);
    my $find_vowels               = join("|", keys %vowels);
    my $find_special_characters   = join("|", keys %special_characters);

    $line =~ s/($find_special_combinations)/$special_combinations{$1}a/g;
    $line =~ s/($find_consonants)($find_combining_vowels)/$consonants{$1}$combining_vowels{$2}/g;
    $line =~ s/($find_consonants)/$consonants{$1}a/g;
    $line =~ s/($find_vowels)/$vowels{$1}/g;
    $line =~ s/($find_special_characters)/$special_characters{$1}/g;

    return $line;
}
