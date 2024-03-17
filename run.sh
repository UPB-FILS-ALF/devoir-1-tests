#!/bin/bash

dir="$(dirname $0)"

function run_test {
    rm -rf output
    filename="$dir/tests/$1"
    outputname="$(dirname $filename)/$(basename $1 .asm).out"
    echo Running $filename
    cd ..
    file=$1
    pathComponents=(${file//// })
    path_with_dir="../devoir-1-tests/tests/${file:2}"
    if [ ${pathComponents[1]} = "bonus" ]
    then
        timeout 50 ./gradlew run -q --args="$path_with_dir 1024" > devoir-1-tests/output
    else
        timeour 50 ./gradlew run -q --args=$path_with_dir > devoir-1-tests/output
    fi
    ERROR=0
    cd devoir-1-tests
    if ! diff output $outputname -Z --side-by-side > error; 
    then
        echo "Your output                                                   | Correct output"
        cat error
        ERROR=1
    else
        echo Correct
    fi
    rm -rf output 
    rm -rf error
    return $ERROR
}

if [ $# -lt 1 ];
then
    echo "Running all tests"
    for folder in "$(cd $dir && find tests -type d -mindepth 1 -maxdepth 1)"
    do
        echo $folder
        for file in ""$(cd $dir/tests && find . -type f -name '*.asm' -mindepth 1 -maxdepth 2)""
        do
            # echo file $file
            run_test $file
        done
    done
else
    run_test $1
fi
