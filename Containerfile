FROM quay.io/fedora-ostree-desktops/kinoite:44

# Packages
RUN dnf -y update && \
    dnf -y install \
    git \
    zsh && \
    dnf clean all

# COPR Packages
RUN dnf -y copr enable scottames/ghostty && \
    dnf -y install ghostty && \
    dnf clean all

# Enable the native bootc background update timer
RUN systemctl enable bootc-fetch-apply-updates.timer

RUN bootc container lint
