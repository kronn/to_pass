#!/usr/bin/env bash

# run rake in some rubies
rvm 1.8.7-p302,1.9.2-p180,rbx-1.2.3 rake
# remove rbx-files
find . -name '*.rbc' | xargs rm
