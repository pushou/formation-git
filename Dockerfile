FROM docker.io/ubuntu:20.04
ENV MDBOOK_VERSION="0.4.40"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y bash ca-certificates curl fonts-roboto git gzip \
                          libreoffice-impress-nogui make tar \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL "https://github.com/rust-lang/mdBook/releases/download/v${MDBOOK_VERSION}/mdbook-v${MDBOOK_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
    | tar -xz --directory=/bin
