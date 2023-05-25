# CustomScriptBuilder
A framework for creating simple ZenPacks that just need to add custom scripts.

Step 1> clone the repo
step 2> add your script to the libexec directory
step 3> run the makepack.sh with -a AUTHOR -v VERSION and -n NAME flags 
step 4> run 'python setup.py bdist_egg' 

Your new pack will be in the dist directory and ready to install.

***This is a work in progress watch for falling rocks***
