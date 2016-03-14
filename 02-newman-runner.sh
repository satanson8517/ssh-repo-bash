#!/bin/bash

# Input parameters
# 1 - Newman parameters
# 2 - collection
# 3 - environment
# 4 - bind environment name to collection name

EXIT_CODE=0
NEWMAN_PARAMETERS=$1
COL=$2
ENV=$3
BIND_ENV_TO_COL=$4

# runs newman
# parameters
# 1 - collection file or directory
# 2 - environment file or directory
function run {
    RUN="newman $NEWMAN_PARAMETERS -c $1 -e $2"

    echo
    cat title-collection.txt
    echo $RUN

    $RUN
    if [ $? != 0 ]; then
        EXIT_CODE=1
    fi
}

# runs newman with environment firmly bound to collection
# parameters
# 1 - collection filename
function run_bound_env_to_col {
    FILE_WITHOUT_PATH=$(basename $1)
    FILE_RADIX=${FILE_WITHOUT_PATH%%.*}
    ENV_FILE=$FILE_RADIX".postman_environment"

    run $1 ${ENV}/${ENV_FILE}
}

# if there's multiple collections run them all in a loop
if [ -d $COL ]; then
    for COL_FILE in $COL/*; do
        if [ $BIND_ENV_TO_COL == true ]; then
            run_bound_env_to_col $COL_FILE
        else
            run $COL_FILE $ENV
        fi
    done
# else run just the one collection
else
    run $COL
fi    

exit $EXIT_CODE
