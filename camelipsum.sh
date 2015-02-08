#!/bin/bash
# Camel Ipsum Generator
echo ">> Camel Ipsum Generator"
if [ $# -eq 0 ] # no arguments passed
	then 
		echo "You need to tell me how many pragraphs."
		exit 1
fi
if [ $# -gt 1 ] # more than one arguments passed
	then 
		echo "You entered more than 1 argument, I don't care the second one."
fi

shuffle() {
   local i tmp size max rand
   size=${#BASE[*]}
   max=$(( 32768 / size * size ))
   for ((i=size-1; i>0; i--)); do
      while (( (rand=$RANDOM) >= max )); do :; done
      rand=$(( rand % (i+1) ))
      tmp=${BASE[i]} BASE[i]=${BASE[rand]} BASE[rand]=$tmp
   done
   # echo ${BASE[*]} 
}

# merges arrays BASE and CAMEL into BASE
merge() {
	local count temp i
	count=${#BASE[@]} temp=$((count+1))
	for (( i=0;i<count;i++ )) do
		BASE[$temp]=${CAMEL[$i]} temp=$((temp+1))
	done
}

BASE=(
	'consectetur' 'adipisicing' 'elit' 'sed' 'do' 'eiusmod' 'tempor'
	'incididunt' 'ut' 'labore' 'et' 'dolore' 'magna' 'aliqua' 'ut' 'enim' 'ad'
	'minim' 'veniam' 'quis' 'nostrud' 'exercitation' 'ullamco' 'laboris' 'nisi'
	'ut' 'aliquip' 'ex' 'ea' 'commodo' 'consequat' 'duis' 'aute' 'irure'
	'dolor' 'in' 'reprehenderit' 'in' 'voluptate' 'velit' 'esse' 'cillum' 'dolore'
	'eu' 'fugiat' 'nulla' 'pariatur' 'excepteur' 'sint' 'occaecat' 'cupidatat' 'non'
	'proident' 'sunt' 'in' 'culpa' 'qui' 'officia' 'deserunt' 'mollit' 'anim' 'id'
	'est' 'laborum'
	)

CAMEL=(
	'camel' 'arab' 'pyramid' 'sun' 'desert' 'toe' 'hump' 'egypt' 'cornivore' 'two-humped'
	'llama' 'alpaca' 'guanaco' 'muslim' 'brown' 'lady fantasy' 'amber' 'camel light' 'camel soft'
	'mammal' 'fat' 'fatty' 'bear grylls' 'kabab'
	)

merge shuffle
base_count=${#BASE[@]} camel_count=${#CAMEL[@]}
printf 'camel ipsum dolor sit amet ' # start with camel ipsum
# loop until input paragraph count has reached
for (( i=0;i<$1;i++ )) do
	# sentence length is between 4 and 21
	length=$((RANDOM%17+4))
	shuffle
	for (( j=0;j<length;j++ )) do
		select_rand=$(($RANDOM%2)) 
		base_rand=$((RANDOM%base_count)) 
		camel_rand=$((RANDOM%camel_count))
		if [ $select_rand -eq 0 ]
			then
				printf %s ${BASE[$base_rand]} ' '
		else
			printf %s ${CAMEL[$camel_rand]} ' '
		fi
	done
	echo
done