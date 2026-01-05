#!/bin/sh

kopi_lexeliste_do_altre_nim() {
    panglo_x="$HOME/panlexia/generated/panglo-$1.md"
    x_panglo="$HOME/panlexia/generated/$1-panglo.md"
    # Kopioi tiedostot oikeisiin kansioihin ja poista otsikot (ensimmäiset 5 riviä)
    #cp "$panglo_x" ./docs/$2/panglota.md
    tail -n +6 "$panglo_x" > ./docs/$2/of_panglo.md
    #cp "$x_panglo" ./docs/$2/panglove.md
    tail -n +6 "$x_panglo" > ./docs/$2/do_panglo.md
}

# Generoi sanastot Panlexiasta.
cd ~/panlexia
rm ./generated/*
mkdir generated
sh tools/generate_bilingual_dictionaries.sh panglo
cd ~/panglo

# Kopioi sanastot eri kielille
kopi_lexeliste_do_altre_nim fin fi
kopi_lexeliste_do_altre_nim eng en
kopi_lexeliste_do_altre_nim epo eo
kopi_lexeliste_do_altre_nim rus ru

# Rakenna sivusto
mkdocs build
