#!/bin/bash

# Le da entrada padrao e colore a saida

# Use colors only if connected to a terminal which supports them
if which tput >/dev/null 2>&1; then
	ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
	RED="$(tput setaf 1)"
	GREEN="$(tput setaf 2)"
	YELLOW="$(tput setaf 3)"
	BLUE="$(tput setaf 4)"
	BOLD="$(tput bold)"
	NORMAL="$(tput sgr0)"
else
	RED=""
	GREEN=""
	YELLOW=""
	BLUE=""
	BOLD=""
	NORMAL=""
fi

while read line
do
  echo "$line" | \
  	sed "s/\(erro[^ \t]*\)/$BOLD$RED\1$NORMAL/gI" |
  	sed "s/\(warn[^ \t]*\)/$BOLD$YELLOW\1$NORMAL/gI" |
  	sed "s/\(info[^ \t]*\)/$BOLD$BLUE\1$NORMAL/gI" |
	sed "s/\((xst|ngdbuild|map|par|bitgen)\)/$BOLD$NORMAL\1$NORMAL/gI"

done < "${1:-/dev/stdin}"

