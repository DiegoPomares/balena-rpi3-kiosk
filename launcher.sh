#!/bin/bash

URL="${URL:-https://www.youtube.com/embed/EyEyojMvveY?autoplay=1&loop=1&playlist=EyEyojMvveY}"
RESTARTAT="${RESTARTAT:-never}"

CMD="chromium-browser --noerrdialogs --disable-session-crashed-bubble --disable-infobars --no-default-browser-check --start-fullscreen"

while true; do
    $CMD "$URL" &
    PID="$!"

    while [ "$(date +%H:%M)" != "$RESTARTAT" ]; do
        sleep 60
    done

    kill -9 "$PID"
done
