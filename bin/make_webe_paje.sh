make_di_MkDocs() {
  cd mkdocs/$1
  mkdocs build
  cd ../..
}

replace_GitHub_folde() {
    grep -rl "edit\/master\/docs" html/$1 | xargs sed -i "s/edit\/master\/docs/edit\/master\/$1/g"
}

make_di_webe_paje() {
    echo $1
    make_di_MkDocs $1
    replace_GitHub_folde $1
}

make_ale() {
    make_di_webe_paje eng
    make_di_webe_paje fin
    make_di_webe_paje fra
    make_di_webe_paje epo
    make_di_webe_paje ita
    make_di_webe_paje por
    make_di_webe_paje spa
    make_di_webe_paje tha
}

make_ale

