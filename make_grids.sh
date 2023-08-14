#!/usr/bin/bash

commandname()
{
    printf 'received %d arguments\n' "$#"
    printf 'listing received filenames\n'

    counter=0
    for par in "$@"
    do
        counter="$(( counter+1 ))"
        printf 'argument number %d: %s' "$counter" "$par" | LC_ALL=POSIX tr -d '[:cntrl:]'
        printf '\n'
    done

    montage $1 $2 $3 $4 $5 $6 $7 $8 $9 -geometry +0+0 -tile 3x3 "./concatenated/${10}.jpg"
    #montage $1 $2 $3 $4 $5 -geometry +0+0 -tile 3x3 "./concatenated/${6}.jpg"

}

set -- # clear positional arguments
i=0
for file in ./resized/*
do
    [ -e "$file" ] || continue
    set -- "$@" "$file"
    if [ "$#" -eq 9 ]
    then
        echo "$file"
        commandname "$@" $i
        set --
        ((i++))
    fi
done
# in case the number of files is a number not divisible by 40
if [ "$#" -gt 0 ] && [ "$#" -lt 40 ]
then
    commandname "$@"
fi
