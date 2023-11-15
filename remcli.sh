#!/bin/bash

while getopts t:m: flag
do
    case "${flag}" in
        t) time=${OPTARG};;
        m) message=${OPTARG};;
    esac
done

if [ -z "$time" ] || [ -z "$message" ]; then
    echo "Usage: remcli -t <time_in_minutes> -m <message>"
    exit 1
fi

if [ ${#message} -gt 56 ]; then
    echo "Message too long. Maximum 56 characters allowed."
    exit 1
fi

# Convert minutes to seconds for sleep
let "time = time * 60"

(
  sleep $time
  osascript -e 'display notification "'"$message"'" with title "Reminder"'
  say "$message"
) &

echo "Reminder set for $time seconds. You will be notified."

