#!/bin/bash

set -u

target=$1
script=$2

sed "s/TARGET/$target/g" < $script > ${target}-$script
