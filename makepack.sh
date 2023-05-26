#!/bin/bash

author=''
name=''
version=''

print_usage() {
  printf "Usage: ..."
}

while getopts 'a:n:v:' flag; do
  case "${flag}" in
    a) author="${OPTARG}" ;;
    n) name="${OPTARG}" ;;
    v) version="${OPTARG}" ;;
    *) print_usage
#       exit 1 ;;
  esac

done

echo $author $name $version

newroot='ZenPacks.'$name'.CustomScripts'
cp -r skel/ZenPacks.example.CustomScripts $newroot
echo $newroot
mv $(find . -mindepth 1 -maxdepth 1 -type d -path . -prune -o -name 'ZenPacks.*')  $newroot
mv $(find ZenPacks.$name.CustomScripts/ZenPacks/ -mindepth 1 -maxdepth 1 -type d) ZenPacks.$name.CustomScripts/ZenPacks/$name

#exit 

cd $newroot
sed -i 's/AUTHOR\ =.*/AUTHOR\ =\ "'$author'"/' setup.py
sed -i "s/example/$name/" setup.py
sed -i 's/VERSION\ =.*/VERSION\ =\ "'$version'"/' setup.py

python setup.py build bdist_egg

cp dist/*.egg ../
