#!/usr/bin/env bash

# require file name
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_to_process>"
    exit 1
fi

# declare name dictionary
declare -A name_map

name_map["X"]="Klaxon"
name_map["E"]="Eryn"
name_map["A"]="Art"
name_map["M"]="Melody"
name_map["K"]="Kefira"
name_map["SC"]="SpaceCat"
name_map["G"]="God"

for key in "${!name_map[@]}"; do
    sed_pattern_base="16,\$s/([^a-zA-Z0-9])$key([^a-zA-Z0-9])/\1${name_map[$key]}\2"
    sed_pattern_print="$sed_pattern_base/gp"
    sed_pattern_replace="$sed_pattern_base/g"

    # print details on what will be replaced
    echo
    echo "Replacing '$key' with '${name_map[$key]}'"
    echo "Using pattern: $sed_pattern_print"
    echo "================ REPLACEMENTS ================"
    sed -nr $sed_pattern_print $1

    # verify changes and then execute
    echo
    echo "Using pattern: $sed_pattern_replace"
    read -n 1 -s -r -p "Confirm changes then press any key to continue..."
    sed -r $sed_pattern_replace $1 > temp_replacement
    mv temp_replacement $1
done

