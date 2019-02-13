#!/usr/bin/env bash
set -e

cat crontab-example | sed 's+FULL_PATH_TO_SCRIPT+'"$(PWD)"'+' | crontab -
