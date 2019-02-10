#!/usr/bin/env bash
# State which applications we want to restart
declare -a crap_apps=("Microsoft Outlook" "Microsoft Teams")

for app_name in "${crap_apps[@]}"; do
  # Gracefully stop the application
  printf "Stopping %s" "${app_name}"
  osascript -e "quit app \"${app_name}\""
  # We'll wait 5 seconds (checking 10 times every half second)
  # if five seconds elapses we force the app to close
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
  # Now that the application is closed, we start it back up
  printf "\nStarting %s\n" "${app_name}"
  open -a "${app_name}"
done
