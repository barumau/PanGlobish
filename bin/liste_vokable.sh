liste_di_worde_from_Panglo_to_X() {
    filename="$2/panglo-$2.md"
    echo "make da file $filename"
    #Panglo unordi
    cat vokable.csv | awk -F "|" "{print \$2 \" - \" \$$1 \"  \"}" > $filename
    #morta unordi linye
    sed -i '1d' $filename
    # alfebete
    sed -i 's/^[A-Z] - .*$/\n## &/' $filename
    # Modify pattern "A - A" to "A\n"
#    sed 's/#[A-Z] -//g' -i $filename
    sed 's/ - [A-Z] /\n/g' -i $filename
    #Add header
    headername="$2/panglo-$2.header.md"
    if test -f "$headername"; then
       echo "$headername exists"
       cat $headername $filename > temp/temp.txt
       mv temp/temp.txt $filename
    else
       echo "$headername doesn't exist. Writing default heading."
       first=`echo $2 | cut -c1 | tr [a-z] [A-Z]`
       second=`echo $2 | cut -c2-`
       otre="$first$second"
       sed -i "1s/^/# Panglo-$otre\n/" $filename
    fi
    #Delete empty translations
    sed -i '/^ - /d' $filename
    sed -i '/-...$/d' $filename
}

liste_di_worde_from_X_to_Panglo() {
    filename="$2/$2-panglo.md"
    echo "make da file $filename"
    #ali bax unordi
    cat vokable.csv | awk -F "|" "{print \$$1 \" - \" \$2 \"  \"}" > $filename
    #morta unordi linye
    sed -i '1d' $filename
    # alfobeta
    cat temp/ABC.txt $filename | LC_ALL=C sort -f > temp/temp.txt
    sed 's/.00/\n## /g' temp/temp.txt > $filename
    # Modify pattern "A - A" to "A\n"
#    sed 's/#[A-Z] -//g' -i $filename
    sed 's/[A-Z] - [A-Z] //g' -i $filename
    #Add header
    first=`echo $2 | cut -c1 | tr [a-z] [A-Z]`
    second=`echo $2 | cut -c2-`
    otre="$first$second"
    sed -i "1s/^/# $otre-Panglo\n/" $filename
    #Delete bullets
    sed 's/• //g' -i $filename
    #Delete empty translations
    sed -i '/^.-/d' $filename
    sed -i '/-...$/d' $filename
}

fata_leksasli_liste() {
    filename="$2/orige.md"
#    cat vokable.csv | awk -F "|" "{print \$$1 \$1 \$4 }" > $filename
    cat vokable.csv | awk -F "|" "{print \"|**\" \$2 \"**|\" \$$1 \"|\" \$5 \"|\"}" > $filename
    #morta unordi linye
    sed -i '1d' $filename
    #Sort
#    LC_ALL=C sort -f $filename --output $filename
    #Add header row
    sed -i "1s/^/| Panglo | $2 | orige |\n/" $filename
    #Add header
    sed -i "1s/^/# Panglo–$2 en di orige of lexe\n\n/" $filename
    #Delete empty translations
    sed -i '/||/d' $filename
    #xula linye 2
    sed 's/|\*\*--/|--/' -i $filename
    sed 's/--\*\*|/--|/' -i $filename
}

make_di_liste() {
    liste_di_worde_from_X_to_Panglo $1 $2
    liste_di_worde_from_Panglo_to_X $1 $2
    fata_leksasli_liste $1 $2
}

fata_lekse_asle() {
    cat vokable.csv | cut -f 1,4 > temp/lekse.txt
    sed -i '1d' temp/lekse.txt
    sed -i 's/\t/ ← /g' temp/lekse.txt
    awk ' { FS=" ← "; OFS=" ← "; t = $1; $1 = $2; $2 = t; print; } ' temp/lekse.txt > temp/temp.txt
    #Delete empty etymologies
    sed -i '/\ ← $/d' temp/temp.txt
    cat temp/ABC.txt temp/temp.txt | sed 's/\t/@/g' | LC_ALL=C sort -f | sed 's/.00/##/g' | sed 's/@/ /g'> temp/lekse.txt
    #Add two spaces to line-ends
    sed 's/$/  /' -i temp/lekse.txt
    cat Panglo/loge_asle_supre.md temp/lekse.txt > Panglo/loge_asle.md
}

tarja_leksaslia_pa_angli() {
    cd English
    sed 's/amh:/Amharic:/' -i leksaslia.md
    sed 's/ara:/Arabic:/' -i leksaslia.md
    sed 's/ben:/Bengali:/' -i leksaslia.md
    sed 's/egy:/Egyptian-Arabic:/' -i leksaslia.md
    sed 's/ell:/Greek:/' -i leksaslia.md
    sed 's/eng:/English:/' -i leksaslia.md
    sed 's/fas:/Persian:/' -i leksaslia.md
    sed 's/fra:/French:/' -i leksaslia.md
    sed 's/ful:/Fulani:/' -i leksaslia.md
    sed 's/guj:/Gujarati:/' -i leksaslia.md
    sed 's/hak:/Hakka-Chinese:/' -i leksaslia.md
    sed 's/hau:/Hausa:/' -i leksaslia.md
    sed 's/hin:/Hindi:/' -i leksaslia.md
    sed 's/hun:/Hungarian:/' -i leksaslia.md
    sed 's/ibo:/Igbo:/' -i leksaslia.md
    sed 's/ita:/Italian:/' -i leksaslia.md
    sed 's/jpn:/Japanese:/' -i leksaslia.md
    sed 's/kan:/Kannada:/' -i leksaslia.md
    sed 's/khm:/Khmer:/' -i leksaslia.md
    sed 's/kon:/Kongo:/' -i leksaslia.md
    sed 's/kor:/Korean:/' -i leksaslia.md
    sed 's/lin:/Lingala:/' -i leksaslia.md
    sed 's/ltn:/Latin:/' -i leksaslia.md
    sed 's/mal:/Malayalam:/' -i leksaslia.md
    sed 's/mar:/Marathi:/' -i leksaslia.md
    sed 's/may:/Malay:/' -i leksaslia.md
    sed 's/min:/Min-Chinese:/' -i leksaslia.md
    sed 's/mya:/Burmese:/' -i leksaslia.md
    sed 's/orm:/Oromo:/' -i leksaslia.md
    sed 's/pnb:/Punjabi:/' -i leksaslia.md
    sed 's/pol:/Polish:/' -i leksaslia.md
    sed 's/por:/Portuguese:/' -i leksaslia.md
    sed 's/rus:/Russian:/' -i leksaslia.md
    sed 's/san:/Sanskrit:/' -i leksaslia.md
    sed 's/spa:/Spanish:/' -i leksaslia.md
    sed 's/swa:/Swahili:/' -i leksaslia.md
    sed 's/tam:/Tamil:/' -i leksaslia.md
    sed 's/tel:/Telugu:/' -i leksaslia.md
    sed 's/tgl:/Filipino:/' -i leksaslia.md
    sed 's/tha:/Thai:/' -i leksaslia.md
    sed 's/tur:/Turkish:/' -i leksaslia.md
    sed 's/urd:/Urdu:/' -i leksaslia.md
    sed 's/vie:/Vietnamese:/' -i leksaslia.md
    sed 's/wol:/Wolof:/' -i leksaslia.md
    sed 's/wuu:/Wu-Chinese:/' -i leksaslia.md
    sed 's/yor:/Yoruba:/' -i leksaslia.md
    sed 's/yue:/Cantonese:/' -i leksaslia.md
    sed 's/zho:/Mandarin:/' -i leksaslia.md
    sed 's/zul:/Zulu:/' -i leksaslia.md
    cd ..
}

tarja_leksaslia_pa_suomi() {
    cd Suomi
    sed 's/amh:/amhara:/' -i leksaslia.md
    sed 's/ara:/arabia:/' -i leksaslia.md
    sed 's/ben:/bangla:/' -i leksaslia.md
    sed 's/egy:/egyptinarabia:/' -i leksaslia.md
    sed 's/ell:/kreikka:/' -i leksaslia.md
    sed 's/eng:/englanti:/' -i leksaslia.md
    sed 's/fas:/persia:/' -i leksaslia.md
    sed 's/fra:/ranska:/' -i leksaslia.md
    sed 's/ful:/fulani:/' -i leksaslia.md
    sed 's/guj:/gujarati:/' -i leksaslia.md
    sed 's/hak:/hakkakiina:/' -i leksaslia.md
    sed 's/hau:/hausa:/' -i leksaslia.md
    sed 's/hin:/hindi:/' -i leksaslia.md
    sed 's/hun:/unkari:/' -i leksaslia.md
    sed 's/ibo:/igbo:/' -i leksaslia.md
    sed 's/ita:/italia:/' -i leksaslia.md
    sed 's/jpn:/japani:/' -i leksaslia.md
    sed 's/kan:/kannada:/' -i leksaslia.md
    sed 's/khm:/khmer:/' -i leksaslia.md
    sed 's/kon:/Kongo:/' -i leksaslia.md
    sed 's/kor:/korea:/' -i leksaslia.md
    sed 's/lin:/lingala:/' -i leksaslia.md
    sed 's/ltn:/latina:/' -i leksaslia.md
    sed 's/mal:/malayalam:/' -i leksaslia.md
    sed 's/mar:/marathi:/' -i leksaslia.md
    sed 's/may:/malaiji:/' -i leksaslia.md
    sed 's/min:/min-kiina:/' -i leksaslia.md
    sed 's/mya:/burma:/' -i leksaslia.md
    sed 's/orm:/oromo:/' -i leksaslia.md
    sed 's/pnb:/pandzabi:/' -i leksaslia.md
    sed 's/pol:/puola:/' -i leksaslia.md
    sed 's/por:/portugali:/' -i leksaslia.md
    sed 's/rus:/venäjä:/' -i leksaslia.md
    sed 's/san:/sanskriitti:/' -i leksaslia.md
    sed 's/spa:/espanja:/' -i leksaslia.md
    sed 's/swa:/suahili:/' -i leksaslia.md
    sed 's/tam:/tamili:/' -i leksaslia.md
    sed 's/tel:/telugu:/' -i leksaslia.md
    sed 's/tgl:/filippiini:/' -i leksaslia.md
    sed 's/tha:/thai:/' -i leksaslia.md
    sed 's/tur:/turkki:/' -i leksaslia.md
    sed 's/urd:/urdu:/' -i leksaslia.md
    sed 's/vie:/vietnami:/' -i leksaslia.md
    sed 's/wol:/wolof:/' -i leksaslia.md
    sed 's/wuu:/wu-kiina:/' -i leksaslia.md
    sed 's/yor:/yoruba:/' -i leksaslia.md
    sed 's/yue:/kantoninkiina:/' -i leksaslia.md
    sed 's/zho:/yleiskiina:/' -i leksaslia.md
    sed 's/zul:/zulu:/' -i leksaslia.md
    cd ..
}

tarja_leksaslia_pa_esperanti() {
    cd Esperanto
    sed 's/amh:/amhara:/' -i leksaslia.md
    sed 's/ara:/araba:/' -i leksaslia.md
    sed 's/ben:/bengala:/' -i leksaslia.md
    sed 's/egy:/egipta araba:/' -i leksaslia.md
    sed 's/ell:/greka:/' -i leksaslia.md
    sed 's/eng:/angla:/' -i leksaslia.md
    sed 's/fas:/persa:/' -i leksaslia.md
    sed 's/fra:/franca:/' -i leksaslia.md
    sed 's/ful:/fula:/' -i leksaslia.md
    sed 's/guj:/guĝarata:/' -i leksaslia.md
    sed 's/hak:/hakaa:/' -i leksaslia.md
    sed 's/hau:/haŭsa:/' -i leksaslia.md
    sed 's/hin:/hindia:/' -i leksaslia.md
    sed 's/hun:/hungara:/' -i leksaslia.md
    sed 's/ibo:/igba:/' -i leksaslia.md
    sed 's/ita:/itala:/' -i leksaslia.md
    sed 's/jpn:/japana:/' -i leksaslia.md
    sed 's/kan:/kanara:/' -i leksaslia.md
    sed 's/khm:/kmera:/' -i leksaslia.md
    sed 's/kon:/konga:/' -i leksaslia.md
    sed 's/kor:/korea:/' -i leksaslia.md
    sed 's/lin:/lingala:/' -i leksaslia.md
    sed 's/ltn:/latina:/' -i leksaslia.md
    sed 's/mal:/malajala:/' -i leksaslia.md
    sed 's/mar:/maratha:/' -i leksaslia.md
    sed 's/may:/malaja:/' -i leksaslia.md
    sed 's/min:/mina:/' -i leksaslia.md
    sed 's/mya:/birma:/' -i leksaslia.md
    sed 's/orm:/oroma:/' -i leksaslia.md
    sed 's/pnb:/panĝaba:/' -i leksaslia.md
    sed 's/pol:/polona:/' -i leksaslia.md
    sed 's/por:/portugala:/' -i leksaslia.md
    sed 's/rus:/rusa:/' -i leksaslia.md
    sed 's/san:/sanskrita:/' -i leksaslia.md
    sed 's/spa:/hispana:/' -i leksaslia.md
    sed 's/swa:/svahila:/' -i leksaslia.md
    sed 's/tam:/tamila:/' -i leksaslia.md
    sed 's/tel:/teluga:/' -i leksaslia.md
    sed 's/tgl:/filipina:/' -i leksaslia.md
    sed 's/tha:/taja:/' -i leksaslia.md
    sed 's/tur:/turka:/' -i leksaslia.md
    sed 's/urd:/urdua:/' -i leksaslia.md
    sed 's/vie:/vjetnama:/' -i leksaslia.md
    sed 's/wol:/volofa:/' -i leksaslia.md
    sed 's/wuu:/vua:/' -i leksaslia.md
    sed 's/yor:/joruba:/' -i leksaslia.md
    sed 's/yue:/kantona:/' -i leksaslia.md
    sed 's/zho:/mandarena:/' -i leksaslia.md
    sed 's/zul:/zulua:/' -i leksaslia.md
    cd ..
}


#dos2unix vokable.csv
sed 's/\t/|/g' -i vokable.csv

# English en Panglo
make_di_liste 6 eng
#fata_leksasli_liste 6 English
#tarja_leksaslia_pa_angli

# Esperanto en Panglo
make_di_liste 23 epo
#tarja_leksaslia_pa_esperanti

# Suomi en Panglo
make_di_liste 24 fin
#tarja_leksaslia_pa_suomi

