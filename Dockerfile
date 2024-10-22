FROM docker.io/ubuntu:20.04
ENV MDBOOK_VERSION="0.4.40"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
                       bash ca-certificates curl fonts-roboto git gzip \
                       libreoffice-impress-nogui make man-db openssh-client \
                       patch tar zip \
    && yes | unminimize \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --profile minimal -c cargo

RUN curl -sSL "https://github.com/rust-lang/mdBook/releases/download/v${MDBOOK_VERSION}/mdbook-v${MDBOOK_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
    | tar -xz --directory=/bin

RUN mkdir -p ~/Desktop
