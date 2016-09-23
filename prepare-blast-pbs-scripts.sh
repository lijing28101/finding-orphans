#!/bin/bash

set -u

database=$1
script=$2

sed "s/DATABASE/$database/g" < $script > ${database}-$script
