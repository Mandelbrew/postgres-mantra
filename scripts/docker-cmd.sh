#!/usr/bin/env sh

set -ef
# set -x # Debug script

# Prep env
IFS=$(echo -en "\n\b")

if [ -z ${MANTRA_SPEC} ] || [ -z ${MANTRA_CMD} ]; then
    echo "ERROR: You need to set MANTRA_SPEC and MANTRA_CMD environment variable"
    exit 1
fi

# Pre fetch
echo "Executing pre-fetch"
if [ ! -z ${MANTRA_PRE_FETCH} ]; then
    eval ${MANTRA_PRE_FETCH};
fi

# Download helper sources
echo "Executing fetch"
if [ ! -z ${MANTRA_FETCH_URL} ]; then
    echo "Downloading resources from ${MANTRA_FETCH_URL}"
    curl -o resources -L --insecure ${MANTRA_FETCH_URL}
fi

# Post fetch
echo "Executing post-fetch"
if [ ! -z ${MANTRA_POST_FETCH} ]; then
    eval ${MANTRA_POST_FETCH};
fi

# Start service
mantra ${MANTRA_SPEC} ${MANTRA_CMD} ${MANTRA_CMD_ARGS}