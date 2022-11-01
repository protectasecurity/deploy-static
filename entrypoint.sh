#!/bin/bash

set -u

function main() {

    if [ "${INPUT_WORKSPACE}" == "" ]; then
        echo "Workspace dir cannot be empty"
        exit 1
    fi

    if [ "${INPUT_BUCKET}" == "" ]; then
        echo "S3 Bucket cannot be empty"
        exit 1
	fi

    if [ "${INPUT_DISTRIBUTION}" == "" ]; then
        echo "Cloudfront Distribution cannot be empty"
        exit 1
	fi

    echo "Run static content deploy for project"
    set -o pipefail

    aws s3 sync ${INPUT_WORKSPACE} s3://${INPUT_BUCKET} && \
    aws cloudfront create-invalidation --distribution ${INPUT_DISTRIBUTION} --paths "/*"

    exitCode=${?}

    set +o pipefail
    echo "status=${exitCode}" >> $GITHUB_OUTPUT

    if [ "${exitCode}" != "0" ]; then
        echo "Static content deploy has failed. See above console output for more details."
        exit 1  
    fi
}

main
