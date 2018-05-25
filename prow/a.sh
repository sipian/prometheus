#!/usr/bin/env bash

IFS=',';
goarch=($ARCH);
for goarch in "${goarchs[@]}"
do
  goos=${goarch%%/*}
  arch=${goarch##*/}
  echo "Arches :: -- $goarch"
done