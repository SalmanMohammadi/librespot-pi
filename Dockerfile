FROM rust:bookworm AS builder
# Install cross-compilation dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libasound2-dev \
    libssl-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Add ARM64 target for modern Raspberry Pi
RUN rustup target add aarch64-unknown-linux-gnu

# Install cross-compilation toolchain
RUN apt-get update && apt-get install -y \
    gcc-aarch64-linux-gnu \
    libc6-dev-arm64-cross \
    && rm -rf /var/lib/apt/lists/*

# Set cross-compilation environment
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
ENV PKG_CONFIG_ALLOW_CROSS=1

WORKDIR /build

# Clone librespot dev branch
RUN git clone --branch dev https://github.com/librespot-org/librespot.git .

# Build for ARM64 with ALSA backend
RUN cargo build --release --target aarch64-unknown-linux-gnu --features "alsa-backend"

# Runtime stage - minimal ARM64 base
FROM debian:bookworm-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    libasound2 \
    alsa-utils \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy binary from builder
COPY --from=builder /build/target/aarch64-unknown-linux-gnu/release/librespot /usr/local/bin/

# Create non-root user
RUN useradd -m -s /bin/bash librespot

USER librespot

ENTRYPOINT ["/usr/local/bin/librespot"]
