#!/bin/bash
# ============ preamble ================== #
set -o errexit #exit when command fails
set -o pipefail #pass along errors within a pipe

prev_dir=$(pwd)

clean_up () {
    ARG=$?
    echo "cleaning up on error"
    cd ${prev_dir}
    exit $ARG
} 
trap clean_up EXIT

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "${script_dir}"

timestamp=$(date +"%Y-%m-%d-%H_%M")

cd ../matsim
mvn -T 4 package -pl matsim -am -DskipTests | tee build_output_${timestamp}.txt

cd "${script_dir}"
mvn -T 4 compile -DskipTests | tee -a build_output_${timestamp}.txt