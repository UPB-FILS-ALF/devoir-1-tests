#!/bin/bash

for folder in tests/*
do
    rm "$folder"/*.out
    for file in "$folder"/*.a 
    do
        echo $file
        node ../index.js $(cat "$file") > "$folder"/$(basename $file .a).out
    done
done
