#/bin/bash

# ********************************************
# **   Purpose: Link a executable from the compiled sources
# **   Parameter
# **   1 - source objectfile name (* for no explicit object file)
# **   2 - project path
# **   3 - project name
# **   4 - Debug (YES/NO)
# **   5 - response file name
# **   6 - subsystem (Console/Windows ...) 
# **   7 - target dll name 
# **   8 - version rc-file path
# ********************************************

OBJECT_NAME=$1
PROJECT_PATH=${PROJECT_SOURCE_ROOT_PATH}/$2
PROJECT_NAME=$3
if [ "$4" = "YES" ]; then
  LINKDEBUG=""
else
  LINKDEBUG=""
fi

RESPONSE_FILE=${PROJECT_SOURCE_ROOT_PATH}/$5
if [ "$6" = "Console" ]; then
  APPL_TYPE=""
else
  APPL_TYPE=""
fi

DLL_NAME=$7

[ "${DLL_NAME}" = "" ] && DLL_NAME=${OBJECT_NAME} 
[ "${DLL_NAME}" = ""  ] && DLL_NAME=${PROJECT_NAME} 
[ "${DLL_NAME}" = "*" ] && DLL_NAME=${PROJECT_NAME}


# remove possible blanks from dllname
# DLL_NAME=$(echo ${DLL_NAME} | sed "| ||g")

VERSION_FILE=$8

if [ "${OBJECT_NAME}" = "*" ]; then
  # this could be done in many ways
  # way one: extract the archive and link the object files like obe does
  rm ${PROJECT_PATH}/lib/*.obj >/dev/zero 2>&1
  pushd . > /dev/zero
  cd ${PROJECT_PATH}/lib/
  ar -x libG4${PROJECT_NAME}.a
  LINK_INPUT=$(ls -1 | grep obj\$ | sed 's|^|'${PROJECT_PATH}'/lib/|')
  popd
  # way two (more elegant)
  # LINK_INPUT=" -Wl,--whole-archive ${PROJECT_PATH}/lib/libG4${PROJECT_NAME}.a -Wl,--no-whole-archive"
else 
  LINK_INPUT=${PROJECT_PATH}/lib/${OBJECT_NAME}
fi

ERRORFILE=${PROJECT_PATH}/temp/${DLL_NAME}.err

# ********************************************
# **   global settings
# ********************************************
	LINK="${LINKDEBUG} -fPIC -shared -lrt -lpthread -ldl"
	LIB=""
	
# ********************************************
# **   version information
# ********************************************
	if [ -e ${VERSION_FILE} ]; then
		echo "sorry no versioning except for the filename"
	fi


# ********************************************
# **   link                                 
# ********************************************
	echo [link] ${DLL_NAME}.dll
	# g++ ${LINK_INPUT} -o ${PROJECT_PATH}/exe/${DLL_NAME}.dll @${RESPONSE_FILE} @${PROJECT_PATH}/lib/exports >> ${PROJECT_PATH}/temp/${DLL_NAME}.err 2>&1

	rcfile=${PROJECT_PATH}/temp/${DLL_NAME}.rc
	echo g++ >${rcfile}
	echo ${LINK} >>${rcfile}
	test -f ${RESPONSE_FILE} && cat ${RESPONSE_FILE} | sed 's|${PROJECT_ROOT_PATH}|'${PROJECT_ROOT_PATH}'|g' | sed 's|${PROJECT_SOURCE_ROOT_PATH}|'${PROJECT_SOURCE_ROOT_PATH}'|g' >>${rcfile}
	echo " ${LINK_INPUT} " >>${rcfile}
	echo -o ${PROJECT_PATH}/exe/${DLL_NAME}.so >>${rcfile}
	$(cat ${rcfile}) >${ERRORFILE} 2>&1

	if [ $? -eq "1" ]; then
	  echo [error] error while linking ${PROJECT_PATH}/exe/${DLL_NAME}.dll
  	  ${PROJECT_SOURCE_ROOT_PATH}/projects/bat/gccShowError.bat ${DLL_NAME} ${2} LINK
	  exit 1
    else
      if [ "${OBJECT_NAME}" = "*" ]; then
        rm ${PROJECT_PATH}/lib/*.obj >/dev/zero 2>&1
      fi
    fi
    echo "success linking ${DLL_NAME}"
    exit 0