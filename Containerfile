ARG FEDORA_VERSION=44

FROM quay.io/fedora-ostree-desktops/kinoite:${FEDORA_VERSION}

RUN dnf -y remove firefox firefox-langpacks && \
    dnf clean all

RUN dnf -y install \
        distrobox \
        just \
        kitty \
        stow \
        ydotool \
        zsh && \
    dnf clean all

RUN dnf -y copr enable scottames/ghostty && \
    dnf -y copr enable alternateved/keyd && \
    dnf -y copr enable birkch/Koi && \
    dnf -y install ghostty keyd Koi && \
    dnf clean all

COPY systemd/bootc-fetch.service /usr/lib/systemd/system/bootc-fetch.service
COPY systemd/bootc-fetch.timer /usr/lib/systemd/system/bootc-fetch.timer

RUN systemctl enable keyd && \
    systemctl enable bootc-fetch.timer && \
    bootc container lint
