#!/bin/bash

top -l 1 | head -10 | grep CPU | awk 'BEGIN {idle = 0;} {idle = $7;} END {print 100 - idle}'
