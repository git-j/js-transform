#!/bin/bash

# ********************************************
# **   Parameter
# **   1 - storage name (class name, executable name ...)
# **   2 - project path (L:, L:\opa\opi\utilities)
# **   3 - project name
# **   4 - action (COMP/LINK)
# ********************************************

OBJECT_NAME=$1
PROJECT_PATH=${PROJECT_SOURCE_ROOT_PATH}/$2
ACTION=$3

# ********************************************
# **   simple solution
# ********************************************

cat ${PROJECT_PATH}/temp/${OBJECT_NAME}.err
