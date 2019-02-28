FROM balenalib/raspberrypi3-debian:stretch-run

ARG USER=kiosk
ARG DEBIAN_FRONTEND=noninteractive

# Create user
RUN adduser --disabled-password --gecos "" $USER \
    && adduser $USER tty \
    && adduser $USER video \
    && adduser $USER sudo \
    && adduser $USER input \
    && echo "$USER ALL=(root) NOPASSWD:ALL" >> /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER \
    && touch .Xauthority

# Install packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends xserver-xorg x11-xserver-utils xinit lxde-core \
    && apt-get install -y dbus-x11 xserver-xorg-input-evdev \
    && apt-get install -y chromium-browser x11vnc lxterminal unclutter \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN rm /usr/bin/lxpolkit

# Copy files
WORKDIR /home/$USER/.config/autostart
COPY launcher.desktop .
WORKDIR /home/$USER
COPY *.sh ./
COPY .xsessionrc .
RUN chown -R $USER:$USER .

ENTRYPOINT ["./entrypoint.sh"]

USER $USER
