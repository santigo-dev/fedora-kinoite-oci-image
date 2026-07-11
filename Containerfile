ARG FEDORA_VERSION=44

FROM quay.io/fedora-ostree-desktops/kinoite:${FEDORA_VERSION}

ARG FEDORA_VERSION

# rpm-fusion & multimedia
RUN dnf -y install \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VERSION}.noarch.rpm && \
    dnf config-manager setopt fedora-cisco-openh264.enabled=1 && \
    dnf swap -y ffmpeg-free ffmpeg --allowerasing && \
    dnf -y install @multimedia intel-media-driver mesa-va-drivers-freeworld && \
    dnf clean all

# packages
RUN dnf -y install \
        distrobox make gcc stow just zsh && \
    dnf clean all --setopt="install_weak_deps=False"

# copr
RUN dnf -y copr enable scottames/ghostty && \
    dnf -y copr enable alternateved/keyd && \
    dnf -y copr enable birkch/Koi && \
    dnf -y install ghostty keyd Koi && \
    dnf clean all && \
    systemctl enable keyd

RUN systemctl enable bootc-fetch-apply-updates.timer && \
    bootc container lint
