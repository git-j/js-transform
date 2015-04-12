#!/bin/bash 
interactive="" # force iecho to read


ds=`date +%Y%m%d`
dts=`date +%Y%m%d-%H%M`
dtfs=`date +%Y%m%d-%H%M%S`

function iecho(){
 ret=0
 echo $1
 if [ ! -z "$interactive" ]; then 
   echo " return to continue, ctrl+D to skip"; 
   read || ret=1
 fi
 return $ret
}

function parameters(){
  # for args
  #echo "enable parameter $1"
  arguments=$2
  for arg in "$1"; do
    case ${arg} in 
      interactive)
        argtest "i" $arguments && interactive=1 && echo "interactive enabled"
      ;;
    esac
  done
  argtest "--help" $arguments && usage
}

function argtest(){
  #echo argtest $@
  for arg in $2; do
    #echo ${arg} $1
    if [ "${arg}" == "$1" ]; then
      #echo found: ${arg} $1
      return 0
    fi
  done
  #echo didnt find $1
  return 1
}

function initemplate(){
  name=$1
  if [ ! -f $name ]; then
    name=${sysconfdir}/odaba/tpl/${name}
  fi
  cat ${name} \
    | sed "s|SOURCE_DATABASE|${SOURCE_DAT}|g" \
    | sed "s|SOURCE_DICTIONARY|${SOURCE_DICT}|g" \
    | sed "s|TARGET_NAME|${TARGET_NAME}|g" \
    | sed "s|TARGET_DICTIONARY_CTX|${TARGET_DICT_CTX}|g" \
    | sed "s|TARGET_DICTIONARY|${TARGET_DICT}|g" \
    | sed "s|TARGET_RESOURCE|${TARGET_RES}|g" \
    | sed "s|TARGET_DATABASE|${TARGET_DAT}|g" \
    | sed "s|%localstatedir%|${localstatedir}|g" \
    | sed "s|%datarootdir%|${datarootdir}|g" \
    | sed "s|%sysconfdir%|${sysconfdir}|g"
}

function usage(){
  echo "shelltool usage:"
  echo "${ARGV}[0] [interactive]"
  exit 0
}
function checkbinstate(){
  case $1 in
    up)
      # find server in process list
      if [ ! -z "`ps aux | grep $2 | grep -v grep`" ]; then
        return 0;
      fi
    ;;
    down)
      if [ ! -z "`ps aux | grep $2| grep -v grep`" ]; then
        return 1;
      fi
      return 0
    ;;
  esac
  return 1
}


function checkserverstate(){
  checkbinstate "$1" "bin/ServerD" && return 0
  return 1
}

function checkodabashell(){
  [ ! -z "${OBE_DIR}" ] && return 0
  return 1
}

function die(){
  echo $1
  exit 1
}