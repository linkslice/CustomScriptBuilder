#!/bin/bash

author=''
name=''
version=''

print_usage() {
  printf "Usage: ./makepack.sh -a <AUTHOR> -n <Company/Packname> -v <VERSION>\n"
}

while getopts 'a:n:v:h' flag; do
  case "${flag}" in
    a) author="${OPTARG}" ;;
    n) name="${OPTARG}" ;;
    v) version="${OPTARG}" ;;
    h) print_usage
       exit 1 ;;
    *) print_usage
       exit 1 ;;
  esac

done

newroot='ZenPacks.'$name'.CustomScripts'
if test -d $newroot ; then rm -rf $newroot ; fi
cp -r skel/ZenPacks.example.CustomScripts $newroot
#mv $(find . -mindepth 1 -maxdepth 1 -type d -path . -prune -o -name 'ZenPacks.*')  $newroot
mv $(find ZenPacks.$name.CustomScripts/ZenPacks/ -mindepth 1 -maxdepth 1 -type d) ZenPacks.$name.CustomScripts/ZenPacks/$name
cp libexec/* $newroot/ZenPacks/$name/CustomScripts/libexec/
chmod +x $newroot/ZenPacks/$name/CustomScripts/libexec/*

#exit 

cd $newroot
sed -i 's/AUTHOR\ =.*/AUTHOR\ =\ '"'$author'"'/' setup.py
sed -i "s/example/$name/" setup.py
sed -i 's/VERSION\ =.*/VERSION\ =\ "'$version'"/' setup.py

python setup.py build bdist_egg >/dev/null 2>&1

cp dist/*.egg ../
cd .. ; ls -1 *.egg
