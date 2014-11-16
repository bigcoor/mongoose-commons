#!/bin/bash

dir=`pwd`
plugin_dir=$dir/plugins

cf_files=`find $dir -type f -name '*.coffee' $mmin_args -print|xargs`

echo ">>> Compiling coffee..."

coffee -c $cf_files

if [ $? -eq 0 ];then
 echo "Coffee compiled success!"
else
 exit 1
fi

echo ">>> Installing dependencies..."
cd $dir
npm install

echo ">>> Finish!"
