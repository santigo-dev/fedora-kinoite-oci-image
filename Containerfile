FROM quay.io/fedora-ostree-desktops/kinoite:44

# Packages
RUN dnf -y update && \
    dnf -y install \
    stow \
    just \
    zsh && \
    dnf clean all

# COPR Packages

# Ghostty
RUN dnf -y copr enable scottames/ghostty && \
    dnf -y install ghostty && \
    dnf clean all

# Koi
RUN dnf -y copr enable birkch/Koi && \
    dnf -y install \
        Koi \
        cmake \
        extra-cmake-modules \
        kf6-kconfigwidgets-devel \
        kf6-kconfig-devel \
        kf6-kcoreaddons-devel \
        kf6-kwidgetsaddons-devel \
        qt6-qtbase-devel \
        hicolor-icon-theme \
        && \
    dnf clean all

# Keyd
RUN dnf -y copr enable alternateved/keyd && \
    dnf -y install \
        keyd \
        && \
    dnf clean all

RUN systemctl enable keyd

RUN systemctl enable bootc-fetch-apply-updates.timer && \
    bootc container lint
