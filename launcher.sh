#!/bin/bash

URL="${URL:-https://www.youtube.com/embed/EyEyojMvveY?autoplay=1&loop=1&playlist=EyEyojMvveY}"
chromium-browser --no-default-browser-check --start-fullscreen "$URL"
