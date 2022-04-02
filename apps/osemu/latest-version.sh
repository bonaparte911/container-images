#!/usr/bin/env bash

version=$(curl -sX GET 'https://raw.githubusercontent.com/oscam-emu/OSEmu/master/VERSION' | grep -oP '(?<=\$Version: ).*(?= \$)')
printf "%s" "${version}"