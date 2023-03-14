#!/bin/bash

for folder in tests/*
do
    rm "$folder"/*.out
    for file in "$folder"/*.a 
    do
        echo $file
        cd "../src/main/java/";
        #node ../index.js $(cat "$file") > "$folder"/$(basename $file .a).out
        java org/example/Main.java $(cat "$file") > "$folder"/$(basename $file .a).out
    done
done
