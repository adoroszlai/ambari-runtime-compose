#!/bin/bash

set -e -u

src="$1"
dst="$2"

[[ -n $dst ]] || exit 1
mkdir -p $dst
default_url="http://www.apache.org/dist/${src}"
url=$(curl -LSs http://www.apache.org/dyn/closer.cgi/${src}?as_json=1 \
 | jq --raw-output '.preferred,.path_info' \
 | sed -e '1N' -e 's/\n//')
: ${url:=$default_url}
echo "Downloading from ${url}"
if ! curl -LSs "${url}" | tar -xzf - --strip-components 1 -C $dst; then
  if [[ $url != $default_url ]]; then
    echo "Retrying download from ${default_url}"
    curl -LSs "${default_url}" | tar -xzf - --strip-components 1 -C $dst
  fi
fi
