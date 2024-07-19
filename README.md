# CustomScriptBuilder
A framework for creating simple ZenPacks that just need to add custom scripts.

Step 1> clone the repo<br>
Step 2> cd to the CustomScriptBuilder directory<br>
step 3> add your script(s) to the libexec directory<br>
step 4> run makepack.sh with -a AUTHOR -v VERSION and -n NAME flags<br>

Your new ZenPack egg will be found in the current directory (next to the makepack.sh script)

Scripts can then be added to a command datasource and called like so:
<pre>/bin/env ${here/ZenPackManager/packs/ZenPacks.NAME.CustomScripts/path}/libexec/SCRIPT-NAME.sh</pre>
The latest version now also puts them in bin. Versions of zenoss higher than 5.3 should allow for scripts to be in the environment and could be called by
<pre>/bin/env check_http <options></pre>
or 
<pre>$ZENHOME/bin/check_http <options></pre>

Author is the only flag that can contain spaces and should be 'QUOTED'<br>  

Alternatively, there's a self-contained docker image available: 
https://github.com/linkslice/ZenPackBuilderDocker

***This is a work in progress watch for falling rocks***
