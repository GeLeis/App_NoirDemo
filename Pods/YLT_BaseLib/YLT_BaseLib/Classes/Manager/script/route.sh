#!/bin/bash

#这个脚本默认的运行目录是app的根目录，首先解析 copyheaderlist.txt中的配置的接口路径，然后拿到接口文件，解析接口文件中的所有方法，生成宏文件。
#此脚本运行环境为 /bin/zsh （终端安装oh-my-zsh）
#source.txt中存储的为接口文件的路径，保持最后一行为空行

SCRIPT_PATH=$(cd "$(dirname "$0")"; pwd) #脚本路径
cd $SCRIPT_PATH
cd ..
rootDir=$(PWD) #工程目录

tmpFile=$SCRIPT_PATH/cache.plist
resultFile=$SCRIPT_PATH/YLT_RouterURLMacro.h

echo "//" > $resultFile
echo "//  YLT_RouterURLMacro" >> $resultFile
echo "//  YLT_RouterURLMacro" >> $resultFile
echo "//" >> $resultFile
echo "//  Created by $USER on $(date +%Y/%m/%d).h" >> $resultFile
echo "//  Copyright © $(date +%Y) YLT_TEAM. All rights reserved." >> $resultFile
echo "//" >> $resultFile
echo "//  author:YLT_TEAM email:ylt_ios@163.com" >> $resultFile
echo -e "\n\r\n#ifndef YLT_RouterURLMacro_h\n#define YLT_RouterURLMacro_h" >> $resultFile


function writeMacro() {
	echo "writeMacro $1"
	filePath=$1
	presubString=$(expr "$filePath" : '\([\.\.\/]*[a-zA-Z0-9_/]*\/\)')
    subfixString=${filePath//$presubString/""}
    classname=${subfixString//".h"/""}
    markString="\n\n#param mark - $classname router\n"
    echo -e $markString >> $resultFile
    defineStr="#define YLT_ROUTER_URL_"$classname"_ylt_router "@\"ylt://$classname/ylt_router\"
    echo $defineStr >> $resultFile

    while read line
    do
        if [ "$line" != "" ]; then
            selPreString=$(expr "$line" : '\([+-][ ]*([a-zA-Z]*)\)')
            if [ "$selPreString" != "" ]; then
                selSubfixString=${line//$selPreString/""}
                selName=$(expr "$selSubfixString" : '\([A-Za-z0-9_]*[:|;]\)')
                selName=${selName//":"/""}
                selName=${selName//";"/""}
                defineStr="#define YLT_ROUTER_URL_"$classname"_"$selName" "@\"ylt://$classname/$selName\"
                echo $defineStr >> $resultFile
            fi
        fi
    done < $filePath

}

function batch_convert() { #递归根目录找文件
filename=""
for file in `ls $1` 
   do
       if [ -d $1"/"$file ]
       then
           batch_convert $1"/"$file $2
       else
       		if [[ "$file" == "$2.h"  ]]; then
       			filename=$1"/"$file
       			/usr/libexec/PlistBuddy -c "Add:$line string ${filename}" $tmpFile	#缓存查找到的路径
       		fi
       fi
   done
}

function readFile() {
    sourcePath=$SCRIPT_PATH/source.txt
    for line in $(<$sourcePath);
        do
            filePath=`/usr/libexec/PlistBuddy -c "print:$line" $tmpFile` #读取缓存路径
			if [ "$filePath" == "" ]; then
				echo "查找路径 $line $rootDir" 
				filePath=`batch_convert $rootDir $line`
			fi
			filePath=`/usr/libexec/PlistBuddy -c "print:$line" $tmpFile` #读取缓存路径

			if [[ "$filePath" != "" ]]; then
				writeMacro $filePath
			fi
        done
}

readFile

echo -e "\n\n#endif /* YLT_RouterURLMacro_h */" >> $resultFile
