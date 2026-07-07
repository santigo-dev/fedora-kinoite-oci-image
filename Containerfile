FROM quay.io/fedora-ostree-desktops/kinoite:44

# packages
RUN dnf -y update && \
    dnf -y install \
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
        Koi \
        cmake \
        extra-cmake-modules \
        kf6-kconfigwidgets-devel \
        kf6-kconfig-devel \
        kf6-kcoreaddons-devel \
        kf6-kwidgetsaddons-devel \
        qt6-qtbase-devel \
        hicolor-icon-theme && \
    dnf clean all && \
    systemctl enable keyd

RUN systemctl enable bootc-fetch-apply-updates.timer && \
    bootc container lint
