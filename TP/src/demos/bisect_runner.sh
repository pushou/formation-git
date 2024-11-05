#!/bin/bash

# Detect and report ugly commits that can't be classified as good or bad
grep -E "Good|Bad" Contenu.txt >/dev/null || exit 125

# Decide if a commit is good or bad
grep -v "Bad" Contenu.txt >/dev/null ; exit $?
