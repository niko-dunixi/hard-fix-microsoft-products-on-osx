#!/usr/bin/env bash
declare -a crap_apps=("Microsoft Outlook" "Microsoft Teams")

for app_name in "${crap_apps[@]}"; do
  printf "Stopping %s" "${app_name}"
  osascript -e "quit app \"${app_name}\""
  count=0
  while pgrep "${app_name}" >/dev/null; do
    printf "."
    sleep 0.5s
    count=$((count + 1))
    if [ $count -gt 10 ]; then
      echo "Taking too long. Force killing with a large rock"
      pkill -3 "${app_name}"
    fi
  done
  printf "\nStarting %s\n" "${app_name}"
  open -a "${app_name}"
done
