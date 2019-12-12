#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5df1d7ac9663cc0013f74491/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5df1d7ac9663cc0013f74491 
fi
curl -s -X POST https://api.stackbit.com/project/5df1d7ac9663cc0013f74491/webhook/build/ssgbuild > /dev/null
cd exampleSite && hugo --gc --baseURL "/" --themesDir ../.. && cd ..
curl -s -X POST https://api.stackbit.com/project/5df1d7ac9663cc0013f74491/webhook/build/publish > /dev/null
