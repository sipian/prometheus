#!/usr/bin/env bash

# Copyright 2016 The Prometheus Authors
# Licensed under the Apache License Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing software
# distributed under the License is distributed on an "AS IS" BASIS
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eo pipefail

echo "Directory name :: $(pwd)"

# This is a Makefile based building processus
[[ ! -e "./Makefile" ]] && echo "Error: A Makefile with 'build' and 'test' targets must be present into the root of your source files" && exit 1

#installing golang
[[ -z "${GOVERSION}" ]] && GOLANG_VERSION="1.10" || GOLANG_VERSION="${GOVERSION}"
curl -fsSL "https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" -o golang.tar.gz \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

export GOPATH="/home/prow/go"
export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"
mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
echo "go version :: $(go version)"
echo "************************ getting all dependencies to run tests. This step will not be needed when running from original prometheus repo *********************"

#running tests
repoName="github.com/prometheus/prometheus"
if [[ -z "${TEST}" ]]; then
  tests=0
elif [ "${TEST}" = "true" ]; then
  		tests=1
	else
	  	tests=0
fi

if [[ -z "${ARCH}" ]]; then
	goarchs=("linux/amd64")
else
        IFS=',';
        goarch=($ARCH);
fi

echo "repoName : $repoName"
echo "Testing Status : $tests"

# Get first path listed in GOPATH
goPath="${GOPATH%%:*}"
repoPath="${goPath}/src/${repoName}"

# Running tests
# The `test` Makefile target is required
tests=${tests:-0}
if [[ ${tests} -eq 1 ]]; then
  # Need to be in the proper GOPATH to run tests
  #cd "${repoPath}" ;
  make test
  exit 0
fi

# TODO
# # Look for the CGO envvar
# CGO_ENABLED=${CGO_ENABLED:-0}
# export CGO_ENABLED
