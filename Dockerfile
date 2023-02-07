# syntax=docker/dockerfile:1

# specify the base image to  be used for the application, alpine or ubuntu
FROM golang:1.19-alpine AS build

# OS we want to build for
ARG BUILD_OS=linux

# run as nonroot user
RUN adduser -u 1001 -D iamuser

# create a working directory inside the image
WORKDIR /app

# copy Go modules and dependencies to image
COPY go.mod ./

# download Go modules and dependencies
RUN go mod download

# copy directory files i.e all files in current folder
COPY . .

# compile application
# in case many main files provide the one
RUN CGO_ENABLED=0 GOOS=${BUILD_OS} go build -a -installsuffix cgo -o app -ldflags="-w -s" main.go
 
##
## STEP 2 - DEPLOY
##
# for alpine we need certificate
# FROM alpine:latest
# RUN apk --no-cache add ca-certificates
FROM scratch

# the tls certificates:
# NB: this pulls directly from the upstream image, which already has ca-certificates:
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

WORKDIR /

COPY --from=build /app /app
COPY --from=build /etc/passwd /etc/passwd

USER 1001

EXPOSE 8080

ENTRYPOINT ["/app/app"]