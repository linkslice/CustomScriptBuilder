# CustomScriptBuilder
A framework for creating simple ZenPacks that just need to add custom scripts.

Step 1> clone the repo<br>
step 2> add your script to the libexec directory<br>
step 3> cd to the CustomScriptBuilder directory and run the makepack.sh with -a AUTHOR -v VERSION and -n NAME flags<br>

Your new ZenPack egg will be found in the pwd next to the makepack.sh script

Scripts can then be added to a command datasource and called like so
<pre>/bin/env ${here/ZenPackManager/packs/ZenPacks.NAME.CustomScripts/path}/libexec/SCRIPT-NAME.sh</pre>

***This is a work in progress watch for falling rocks***
