FROM quay.io/fedora-ostree-desktops/kinoite:44

# packages
RUN dnf -y install \
        stow \
        just \
        zsh && \
    dnf clean all

# third-party software: COPR packages
RUN dnf -y copr enable scottames/ghostty && \
    dnf -y copr enable alternateved/keyd && \
    dnf -y copr enable birkch/Koi && \
    dnf -y install \
        ghostty \
        keyd \
        Koi && \
    dnf clean all && \
    systemctl enable keyd

RUN systemctl enable bootc-fetch-apply-updates.timer && \
    bootc container lint
