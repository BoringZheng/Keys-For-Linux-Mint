#!/usr/bin/env bash
#Usage:
#   sudo ./configure.sh -t space -t dire -t control -t home-end
#Flags (repeatable):
#   space   -> space = overload(nav, space)
# dire    -> nav layer: w/a/s/d ->up/left/down/right
# control     -> nav layer: capslock -> lctrl
# home-end    -> nav layer: q/e -> home/end
# fmap    -> nav layer: 1-= -> f1-f12

set -euo pipefail

SPACE_LAYER=0
DIRE_MAP=0
CTRL_CAPS=0
HOME_END=0
F_MAP=0

while (( "$#" )); do
    case "$1" in
        -t)
            tok="${2:-}"; shift 2 || true
            case "$tok" in
                space) SPACE_LAYER=1 ;;
                dire) DIRE_MAP=1 ;;
                control) CTRL_CAPS=1 ;;
                home-end) HOME_END=1 ;;
                fmap) F_MAP=1 ;;
                *) echo "Unknown token: $tok"; exit 1 ;;
            esac
            ;;
        -h|--help)
            sed -n '1,60p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    esac
done

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root."
    exit 1
fi

CONFIG="[ids]

*

[main]
"
if [[ $CTRL_CAPS -eq 1 ]]; then
    CONFIG+="capslock = leftcontrol 
"
fi

if [[ $SPACE_LAYER -eq 1 ]]; then
    CONFIG+="space = overload(nav, space)
"
fi

CONFIG+="[nav]
"

if [[ $DIRE_MAP -eq 1 ]]; then
    CONFIG+="w=up
a=left
s=down
d=right
"
fi

if [[ $HOME_END -eq 1 ]]; then
    CONFIG+="q=home
e=end
"
fi

if [[ $F_MAP -eq 1 ]]; then
    CONFIG+="1=f1
2=f2
3=f3
4=f4
5=f5
6=f6
7=f7
8=f8
9=f9
0=f10
-=f11
==f12
"
fi

printf "%s\n" "$CONFIG" > /etc/keyd/default.conf
echo "Wrote /etc/keyd/default.conf"

systemctl restart keyd
echo "Restarted keyd service"
keyd reload
echo "Reloaded keyd configuration"