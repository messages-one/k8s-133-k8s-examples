#!/bin/bash

echo "YAML files in current directory (without extension):"
for file in *.yaml; do
    if [ -f "$file" ]; then
        filename="${file%.yaml}"  # Removes .yaml from the end
        echo "$filename"

        echo -e "\nprocessing resource $filename\n\n" 
        
	# remove all the lines starting from the word KIND and upto FIELDS
        sed -i '/^KIND/,/^FIELDS/d' $filename.yaml

        sed -i -E 's/[[:space:]]+</\: \#</g' ${filename}.yaml
	
	# remove the first line from the file	
        sed -i '1d' $filename.yaml
	
	# sometimes we need to remove 3 spaces sometimes 2 spaces
        # data="$(cut -c 3- $filename.yaml)" 

        # remove 2 spaces at the beginning
        data="$(sed 's/^  //' ${filename}.yaml)"

        # data="$(echo "$data" | yq -P '.')"
        data="$(echo "$data")"
        echo "$data"
        rm -f ${filename}.yaml
        echo "$data" | tee -a ${filename}.yaml 
        echo '     ----      '
    fi
done

