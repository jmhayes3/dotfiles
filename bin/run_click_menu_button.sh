#!/usr/bin/env bash

osascript -e 'tell application "System Events"
	tell process "NotificationCenter"
		click menu button 1 of window 1
	end tell
end tell'
