#!/usr/bin/env bash

## Requirements: curl / jq

VERSION=0.9.1-3360
EXTNAME=".dll" # dylib | so
FINALEXTNAME=".dll"

## download the list of released extensions
curl -L https://github.com/litedb/litedb/releases/download/0.9.1-3360/extensions.json --output extensions.json

## extract extensions as list
exts=$(cat extensions.json | jq -r ".extensions[]")
download(){
    for ext in $exts ; do
        url="https://github.com/litedb/litedb/releases/download/$VERSION/$ext$EXTNAME"
        cmd="wget $url -O $ext$FINALEXTNAME"
        # echo $cmd ## for debugging
        $($cmd)
    done
}

# compiled extensions for Apple M1 (arm64) are handled locally in manual fashion until Github Actions support it!

mkdir -p priv/darwin-amd64
pushd priv/darwin-amd64
rm *
EXTNAME=".dylib"
FINALEXTNAME=".dylib"
download

popd
mkdir -p priv/windows-amd64
pushd priv/windows-amd64
rm *
EXTNAME=".dll"
FINALEXTNAME=".dll"
download

popd
mkdir -p priv/windows-win32
pushd priv/windows-win32
rm *
EXTNAME="-win32.dll"
FINALEXTNAME=".dll"
download

popd
mkdir -p priv/linux-amd64
pushd priv/linux-amd64
rm *
EXTNAME=".so"
FINALEXTNAME=".so"
download
