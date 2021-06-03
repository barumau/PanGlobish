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
    make_di_webe_paje english
    make_di_webe_paje suomi
    make_di_webe_paje esperanto
    make_di_webe_paje tai
}

make_ale

rm -rf ../html/PanGlobish
cp html ../html/PanGlobish -r
