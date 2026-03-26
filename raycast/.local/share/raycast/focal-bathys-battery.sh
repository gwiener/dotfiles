#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Focal Bathys Battery
# @raycast.mode inline

# Optional parameters:
# @raycast.refreshTime 1m
# @raycast.icon 🎧

# Documentation:
# @raycast.description Get the battery level for my headphones
# @raycast.author Guy Wiener

pmset -g accps | grep -i focal | cut -f2 | cut -d\; -f1
