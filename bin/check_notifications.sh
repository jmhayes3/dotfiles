#!/usr/bin/env bash

osascript -e '
  tell application "System Events"
      tell process "NotificationCenter"
          set theseWindows to every window whose subrole is "AXNotificationCenterAlert" or subrole is "AXNotificationCenterBanner"
          set theseTitles to {}
          repeat with thisWindow in theseWindows
              try
                if currentTitles contains "a" then
                    tell application "Finder"
                        activate
                    end tell
                end if
              end try
          end repeat
          return theseTitles
      end tell
  end tell
'
