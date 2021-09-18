#!/bin/bash

top -l 1 | head -10 | grep PhysMem | awk 'BEGIN {tot = 0;} {tot = $2 + $6;} END {printf "%s/%sG\n", $2, tot}'
