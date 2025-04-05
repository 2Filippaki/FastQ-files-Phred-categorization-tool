#!/bin/bash

echo -e "Name of Directory:"
read dir

if [ -d "$dir" ]; then
    echo "Valid Directory!"

    if [ ! -d "$dir/Phred33" ]; then
        mkdir "$dir/Phred33"
        echo "Created Phred33 folder."
    fi
    if [ ! -d "$dir/Phred64" ]; then
        mkdir "$dir/Phred64"
        echo "Created Phred64 folder."
    fi

    for file in "$dir"/*.fastq; do
        if [ -f "$file" ]; then
	    echo "_______________________________"

            echo "For file: $file"

            qualines=$(awk 'NR % 4 == 0' "$file")
            asciival=$(echo "$qualines" | od -An -t u1 | tr -s ' ' '\n' | grep -o '[0-9]\+' | grep -v '^10$' | grep -v '^32$')
            validasciichar=$(echo "$asciival" | awk '{if ($1 >= 33 && $1 <= 104) print $1}')

            if [ -z "$validasciichar" ]; then
                echo "No valid quality scores found in $file, skipping..."
                continue
            fi

            phred_type="Unknown"
            for value in $validasciichar; do
                if [ "$value" -ge 33 ] && [ "$value" -le 64 ]; then
                    phred_type="Phred+33"
                elif [ "$value" -ge 64 ] && [ "$value" -le 104 ]; then
                    phred_type="Phred+64"
                else
                    echo "Invalid ASCII value found: $value. Skipping $file."
                    continue 2
                fi
            done

            if [ "$phred_type" == "Phred+33" ]; then
                echo "The file is in Phred+33 format."
	        echo "_______________________________"
                mv "$file" "$dir/Phred33/"
            elif [ "$phred_type" == "Phred+64" ]; then
                echo "The file is in Phred+64 format."
       	        echo "_______________________________"
                mv "$file" "$dir/Phred64/"
            fi
        fi
    done
else
    echo "Not a valid Directory."
fi
