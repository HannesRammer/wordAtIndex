lSet=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
uSet=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
dSet=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
sSet=(" " "!" "\"" "#" "\$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/" ":" ";" "<" "=" ">" "?" "@" "[" "\\" "]" "^" "_" "\`" "{" "|" "}" "~")
set1=()
set2=()
set3=()
set4=()

mask=""
maskLength=0
wordLength=0
wordSet=()

index=0

displayHelpMenu(){

echo "wordAtIndex generator by Hannes Rammer,
Returns the word of a mask given its index.
Purpose: split a mask for eg distributed computing [brute force]

pc1 -> mask[0-100000000]
pc2 -> mask[100000001-200000000]
...

Usage: sh wai.sh -i index -m mask [charset]

* Info:

  -v,  Display version number
  -h,  Display this help menu

* generation:

  -i,  Index for Word; fist word at index 0
  -m,  Specify mask via Built-in charsets

       Example:
       
       sh wai.sh -i 13 -m ?d?d?d  
       
       sets mask to length 3 with only digits

* Custom charsets:

  -1, -2, -3, -4,  Specify custom charsets via Built-in charsets

       Example:

       sh wai.sh -i 13 -m ?1?d?2 -1 ?dab -2 ?d

       sets charset ?1 to 0123456789ab and ?2 to 0123456789
 
       IMPORTANT -1 ?d?l NOT EQUAL -1 ?l?d

* Built-in charsets:

  ?l = abcdefghijklmnopqrstuvwxyz
  ?u = ABCDEFGHIJKLMNOPQRSTUVWXYZ
  ?d = 0123456789
  ?s =  !\"#\$%&'()*+,-./:;<=>?@[\\]^_\`{|}~

"
}

setCustomSet(){
  echo "*****set custom sets $1*****"
  setLength=${#OPTARG}
  
  for((i=0;i < $setLength;i++))
  do
    if [ "${OPTARG:$i:1}" == "?" ] && ([ "${OPTARG:$i+1:1}" == "l" ]  || 
       [ "${OPTARG:$i+1:1}" == "u" ] || [ "${OPTARG:$i+1:1}" == "d" ] ||  
       [ "${OPTARG:$i+1:1}" == "s" ])
    then
      i=$(expr $i + 1)
      newCustomSet="set$optname[@]"
      
      newCharSet="${OPTARG:$i:1}Set[@]"
      if [ "$optname" == "1" ]
      then
      set1=("${set1[@]}" "${!newCharSet}")
      elif [ "$optname" == "2" ]
      then
      set2=("${set2[@]}" "${!newCharSet}")
      elif [ "$optname" == "3" ]
      then
      set3=("${set3[@]}" "${!newCharSet}")
      elif [ "$optname" == "4" ]
      then
      set4=("${set4[@]}" "${!newCharSet}")
      fi
      echo "added $newCharSet : '${!newCharSet}'"
      
    else #if single char
    newCustomSet="set$optname[@]"
    echo "char ${OPTARG:$i:1} "
    if [ "$optname" == "1" ]
      then
        set1=("${set1[@]}" "${OPTARG:$i:1}")
      elif [ "$optname" == "2" ]
      then
        set2=("${set2[@]}" "${OPTARG:$i:1}")
      elif [ "$optname" == "3" ]
      then
        set3=("${set3[@]}" "${OPTARG:$i:1}")
      elif [ "$optname" == "4" ]
      then
        set4=("${set4[@]}" "${OPTARG:$i:1}")
      fi
      echo "added '${OPTARG:$i:1}'"
    fi
    
  done
  echo ""
  echo "set$optname = ${!newCustomSet}"
  #echo "*****end set custom sets*****"
        
}

timeNeeded(){
  keysPerSec=$1
  combis=$2
  seconds=$(expr $combis / $keysPerSec)
  minutes=$(expr $seconds / 60)
  hours=$(expr $minutes / 60)
  days=$(expr $hours / 24)
  years=$(expr $days / 356)
  echo "time for $combis words at ${keysPerSec}/s "
  echo "$minutes mins or $hours hours or $days days or $years years"
  echo ""
}

while getopts ":hi:m:v1:2:3:4:" optname
  do
case "$optname" in
      "v")
        echo "wordAtIndex Version 0.0.1"
        ;;
      "h")
        displayHelpMenu
        ;;
      "i")
        index=$OPTARG
        ;;
      "m")
        echo "*****generate wordset*****"
        echo ""
        mask=$OPTARG
        echo "Mask set to $OPTARG"
        maskLength=${#OPTARG}
        echo "MaskLength set to $maskLength"
        #echo ""
        for((i=0;i < $maskLength;i++))
        do
          char="${OPTARG:$i:1}"
          #if charset 1 2 3 4 l u d s
          if [ "$char" == "?" ] && ([ "${OPTARG:$i+1:1}" == "1" ]  || 
             [ "${OPTARG:$i+1:1}" == "2" ] || [ "${OPTARG:$i+1:1}" == "3" ] ||  
             [ "${OPTARG:$i+1:1}" == "4" ] || [ "${OPTARG:$i+1:1}" == "l" ]  || 
             [ "${OPTARG:$i+1:1}" == "u" ] || [ "${OPTARG:$i+1:1}" == "d" ] ||  
             [ "${OPTARG:$i+1:1}" == "s" ])
          then
            i=$(expr $i + 1)
            #echo "current set = $char${OPTARG:$i:1}"
            wordLength=$(expr $wordLength + 1)  
            #echo ""    #if custom charset 1 2 3 4
            if [ "${OPTARG:$i:1}" == "1" ]  || [ "${OPTARG:$i:1}" == "2" ] ||
               [ "${OPTARG:$i:1}" == "3" ] ||  [ "${OPTARG:$i:1}" == "4" ]
            then
              newCharSet="set${OPTARG:$i:1}[@]"
            #if build-in charset l u d s
            elif [ "${OPTARG:$i:1}" == "l" ]  || [ "${OPTARG:$i:1}" == "u" ] ||
               [ "${OPTARG:$i:1}" == "d" ] ||  [ "${OPTARG:$i:1}" == "s" ] 
            then
              newCharSet="${OPTARG:$i:1}Set[@]"
            fi
            wordSet=("${wordSet[@]}" "$newCharSet")
            #echo "added '$newCharSet' to wordSet at pos $wordLength"
          else #if single char
            #echo "current char = $char"
            wordLength=$(expr $wordLength + 1)
            wordSet=("${wordSet[@]}" "$char")
            #echo "added '$char' to wordSet at pos $wordLength"
          fi
          #echo ""
        done
        echo "WordLength is $wordLength"
        echo "wordset = ${wordSet[@]}"
        #echo ""
        #echo "*****end generate wordset*****"
        ;;
      "1")
        setCustomSet 1
        ;;
      "2")
        setCustomSet 2
        ;;
      "3")
        setCustomSet 3
        ;;
      "4echo """)
        setCustomSet 4
        ;;
      "?")
        echo "Unknown option $OPTARG"
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        ;;
      *)
      # Should not occur
        echo "Unknown error while processing options"
        ;;
    esac
  done
  echo "*****word generation*****"
  echo "index $index"
  echo "wordlength $wordLength"
      
  #get max combinations    
  combinations=0
  for((i=0;i<$wordLength;i++))
  do
    #echo "char ${wordSet[$i]}"
    #echo "value ${!wordSet[$i]}"
    array=("${!wordSet[$i]}")
    #echo "length ${#array[@]}"
    if [ "$i" == "0" ] 
    then
      combinations=${#array[@]}
    else
      combinations=$(expr $combinations * ${#array[@]})
    fi
    
  done
  if [ "$combinations" -lt "$index" ]  
  then
  echo "**********************************************************"
  echo "*index $index out of range max $combinations combinations*"
  echo "**********************************************************"
  else
    echo ""
    #echo "mask $mask"
    #echo "wordSet ${wordSet[@]}"
    echo "combinations $combinations"
    
    timeNeeded 10000 $combinations
    timeNeeded 1000000000000 $combinations
    timeNeeded 1000000000000000000000000 $combinations
    timeNeeded 10000 $index
    
    #echo "*****end word generation*****"

    calIndex=$(expr $index - 1)
    rest=0
    wordAtIndex=""
    for((i=$wordLength-1;i>=0;i--))
    do
      if [ "${wordSet[$i]}" == "lSet[@]" ] || [ "${wordSet[$i]}" == "uSet[@]" ] ||
         [ "${wordSet[$i]}" == "dSet[@]" ] || [ "${wordSet[$i]}" == "sSet[@]" ] ||
         [ "${wordSet[$i]}" == "set1[@]" ] || [ "${wordSet[$i]}" == "set2[@]" ] ||
         [ "${wordSet[$i]}" == "set3[@]" ] || [ "${wordSet[$i]}" == "set4[@]" ] 
      then
      #echo "char ${wordSet[$i]}"
      #echo "${!wordSet[$i]}"
      array=("${!wordSet[$i]}")
      rest=$(expr $calIndex % ${#array[@]})
      
      wordAtIndex=${array[$rest]}$wordAtIndex
      #echo "${array[$rest]}"
      calIndex=$(expr $calIndex / ${#array[@]})
      #echo "rest $rest"
      #echo "new index $calIndex"
      else
        wordAtIndex=${wordSet[$i]}$wordAtIndex
      fi
    
    done
    echo "$wordLength character word at index $index from max $combinations words"
    echo "********************************************"
    echo "*>>>>'$wordAtIndex'<<<<*"
    echo "********************************************"
    echo "without surrounding '' "
    echo
    
    
    #add split into array -s
    #add -t time stats ??
  fi