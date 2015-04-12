#!/bin/bash

# ********************************************
# **   Parameter
# **   1 - source storage name (class name, executable name ...)
# **   2 - project path (L:, L:\opa\opi\utilities)
# **   3 - project name
# **   4 - debug (YES/NO)
# **   5 - response file name
# **   6 - application type (Console/Windows ...) 
# **   7 - programm language ( C++ is assumed for all other than C) 
# **   8 - store object (YES/NO)
# ********************************************

SOURCE_NAME=$1
PROJECT_PATH=${PROJECT_SOURCE_ROOT_PATH}/$2
PROJECT_NAME=$3
if [ "$4" = "YES" ]; then
  DEBUG=-ggdb3 
else
  DEBUG=
fi

RESPONSE_FILE=$5
if [ "$6" = "Console" ]; then 
  APPL_TYPE=
else
  APPL_TYPE=
fi

if [ "$7" = "C" ]; then
  C_CODE=-xc 
else
  C_CODE=-xc++
fi
STORE_OBJ=$8

# ********************************************
# **   glocal settings
# ********************************************
	ERROR=
	CL="${APPL_TYPE} ${C_CODE} -w -fpermissive -fhandle-exceptions -fPIC -shared ${DEBUG}"
	INCLUDE=-I/usr/include
	ERRORFILE=${PROJECT_PATH}/temp/${SOURCE_NAME}.err
	rm ${PROJECT_PATH}/temp/gerr.tmp 2>/dev/zero

# ********************************************
# **   Compile - G++    
# ********************************************
	echo [compile] ${SOURCE_NAME}.cpp
	
	rcfile=${PROJECT_PATH}/temp/${SOURCE_NAME}.rc
	echo g++ >${rcfile}
	cat ${RESPONSE_FILE} | sed 's|${PROJECT_ROOT_PATH}|'${PROJECT_ROOT_PATH}'|g' | sed 's|${PROJECT_SOURCE_ROOT_PATH}|'${PROJECT_SOURCE_ROOT_PATH}'|g' >>${rcfile}
	echo " ${CL}" >>${rcfile}
	echo ${PROJECT_PATH}/qlib/${SOURCE_NAME}.cpp -o ${PROJECT_PATH}/lib/${SOURCE_NAME}.obj >>${rcfile}
	$(cat ${rcfile}|sed 's|#.*$|') >${ERRORFILE} 2>&1

	if [ $? -eq "1" ]; then
# ********************************************
# **   Compile error 
# ********************************************
  	  echo [error] failed to compile ${SOURCE_NAME}.cpp
  	  ${PROJECT_SOURCE_ROOT_PATH}/projects/bat/gccShowError.bat ${SOURCE_NAME} ${2} COMP
	  exit 1
	else
	  if [ -e ${ERRORFILE} ]; then 
	    rm ${ERRORFILE}
	  fi
	  if [ -e ${rcfile} ]; then 
	    rm ${rcfile}
	  fi
	  if [ "${STORE_OBJ}" = "YES" ]; then
	    echo "object stored"
	  else
# ********************************************
# **   Add to Library
# ********************************************
		pushd . >/dev/zero 2>&1
		  cd ${PROJECT_PATH}/lib/
  	      ar r libG4${PROJECT_NAME}.a ${SOURCE_NAME}.obj > /dev/zero 2>&1
  	    popd >/dev/zero 2>&1
	    if [ $? -eq "1" ]; then
	      echo "failed to add ${SOURCE_NAME}.obj to libG4${PROJECT_NAME}.a" >> ${ERRORFILE}
	      exit 1
	    fi
	    rm ${PROJECT_PATH}/lib/${SOURCE_NAME}.obj 
	  fi
	  echo "success compiling ${SOURCE_NAME}"
	fi

