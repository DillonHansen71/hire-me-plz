# set argggs
ARG IMG_TAG=latest

# start from alpine
FROM golang:1.18-alpine AS gaiad-builder

# Install packages
ENV PACKAGES curl make git libc-dev bash gcc linux-headers eudev-dev python3
RUN apk add --no-cache $PACKAGES

WORKDIR /src/app/

# Download the source code
RUN git clone https://github.com/cosmos/gaia.git

# change working directory to cloned repo
WORKDIR /src/app/gaia

# Checkout the desired version
RUN git checkout v7.1.0

# download dependencies
RUN go mod download

# install from source
RUN CGO_ENABLED=0 make install

# Add to a distroless container
FROM distroless.dev/static:$IMG_TAG
ARG IMG_TAG
COPY --from=gaiad-builder /go/bin/gaiad /usr/local/bin/
EXPOSE 26656 26657 1317 9090
USER 0
# COPY genesis.json /root/.gaia/config/
ENTRYPOINT ["gaiad"]

# Print output to the console
CMD ["start"]