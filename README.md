# balena-rpi3-kiosk
RPi3 balena image for a kiosk.

## How to use
1. Create Balena app and add devices. https://www.balena.io/docs/learn/getting-started/raspberrypi3/nodejs/
1. In the app, create the `URL` environment/device variable with the desired URL for the kiosk.
1. Clone this repository.
1. Add Balena app as remote: `git remote add balena USER@git.balena-cloud.com:REPOSITORY`
1. Push to balena to deploy the code: `git push balena master`
1. To connect via VNC, use the password in the devices's log in Balena's dashboard.

## Tips
- After some testing with GPU memory size, setting `RESIN_HOST_CONFIG_gpu_mem=128` in Balena's _Fleet configuration_ seems to be the best.
- The `RESTARTAT` environment variable can be used to make the browser restart once a day at a desired time, format it as `HOUR:MINUTE` (`date +%H:%M`)

## Notes
- Chromium won't work properly when launched as root, even with the `--no-sandbox` flag. That's why both Chromium and LXDE have to be launched with a regular user, permisions have to be set to `777` to some /dev devices, and [~/.Xauthority](https://askubuntu.com/questions/300682/what-is-the-xauthority-file) created.
- The executable `/usr/bin/lxpolkit` is removed because it's autostarted somewhere and displays an annoying error message.
- Unclutter is used to hide the mouse cursor, was the only thing that worked reliably.
