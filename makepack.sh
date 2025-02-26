#!/bin/bash

author=''
name=''
version=''
plugins=false

print_usage() {
  printf "Usage: ./makepack.sh -a <AUTHOR> -n <Company/Packname> -v <VERSION>\n"
}

while getopts 'a:n:v:hps' flag; do
  case "${flag}" in
    a) author="${OPTARG}" ;;
    n) name="${OPTARG}" ;;
    v) version="${OPTARG}" ;;
    p) plugins=true ;;
    s) symlinks=true ;; 
    h) print_usage
       exit 1 ;;
    *) print_usage
       exit 1 ;;
  esac

done
# see if we're in Docker
if [ `pwd` == '/' ] ; then
  cd CustomScriptBuilder
fi

newroot='ZenPacks.'$name'.CustomScripts'
if test -d $newroot ; then rm -rf $newroot ; fi

cp -r skel/ZenPacks.example.CustomScripts $newroot
#mv $(find . -mindepth 1 -maxdepth 1 -type d -path . -prune -o -name 'ZenPacks.*')  $newroot
mv $(find ZenPacks.$name.CustomScripts/ZenPacks/ -mindepth 1 -maxdepth 1 -type d) ZenPacks.$name.CustomScripts/ZenPacks/$name

if [[ $plugins == true ]] ; then
  if test -f /usr/bin/yum ; then
    yum install nrpe nagios-plugins-http nagios-plugins-dig -y
    cp /usr/lib64/nagios/plugins/check_* $newroot/ZenPacks/$name/CustomScripts/libexec/
  fi
  if test -f /usr/bin/apt ; then
    apt update 
    export DEBIAN_FRONTEND=noninteractive
    export TZ=Etc/UTC 
    apt install -y monitoring-plugins-standard nagios-nrpe-plugin
    cp /usr/lib/nagios/plugins/check_* $newroot/ZenPacks/$name/CustomScripts/libexec/
  fi
fi

if test -d /mnt/pwd/libexec ; then
  cp /mnt/pwd/libexec/* $newroot/ZenPacks/$name/CustomScripts/libexec/
fi
if test -d libexec ; then
  cp libexec/* $newroot/ZenPacks/$name/CustomScripts/libexec/
fi

chmod +x $newroot/ZenPacks/$name/CustomScripts/libexec/*
mkdir $newroot/ZenPacks/$name/CustomScripts/bin
cp -r $newroot/ZenPacks/$name/CustomScripts/libexec/* $newroot/ZenPacks/$name/CustomScripts/bin/

#test if we're in zenpacklab
if test -d /usr/src/zenpacklab-storage/libexec/ ; then
  cp /usr/src/zenpacklab-storage/libexec/* $newroot/ZenPacks/$name/CustomScripts/libexec/
  cp /usr/src/zenpacklab-storage/libexec/* $newroot/ZenPacks/$name/CustomScripts/bin/
fi


if [[ $symlinks == true ]] ; then
  cp skel/symlink/__init__.py $newroot/ZenPacks/$name/CustomScripts/
fi

cd $newroot
sed -i 's/AUTHOR\ =.*/AUTHOR\ =\ '"'$author'"'/' setup.py
sed -i "s/example/$name/" setup.py
sed -i 's/VERSION\ =.*/VERSION\ =\ "'$version'"/' setup.py

python setup.py build bdist_egg >/dev/null 2>&1

cp dist/*.egg ../
cd .. ; ls -1 *.egg
if test -d /mnt/pwd ; then cp *.egg /mnt/pwd/ ; fi

