APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=gcr.io/tetris-effect-419120/kbot
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

.DEFAULT_GOAL := build

TARGETOS=
TARGETARCH=

build_linux: TARGETOS=linux
build_linux: TARGETARCH=arm64
build_linux: build

linux: TARGETOS=linux
linux: TARGETARCH=arm64
linux: build

windows: TARGETOS=windows
windows: TARGETARCH=amd64
windows: build

macOS: TARGETOS=darwin
macOS: TARGETARCH=amd64
macOS: build_macOS

macOSARM: TARGETOS=darwin
macOSARM: TARGETARCH=arm64
macOSARM: build_macOSARM

format:
	gofmt -s -w ./

gocritic:
	gocritic check ./...

test:
	go test -v  

get:
	go mod tidy
	go mod download

build: format get
	GO_VERSION=1.20
	export GO_VERSION
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o kbot -ldflags "-X 'gcr.io/tetris-effect-419120/kbot/kbot.git/cmd.appVersion=$(VERSION)'"

build_macOS: format get
	GO_VERSION=1.20
	export GO_VERSION
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o kbot -ldflags "-X 'gcr.io/tetris-effect-419120/kbot/kbot.git/cmd.appVersion=$(VERSION)'"

build_macOSARM: format get
	GO_VERSION=1.20
	export GO_VERSION
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -v -o kbot -ldflags "-X 'gcr.io/tetris-effect-419120/kbot/kbot.git/cmd.appVersion=$(VERSION)'"

build_windows: format get
	GO_VERSION=1.20
	export GO_VERSION
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot -ldflags "-X 'gcr.io/tetris-effect-419120/kbot/kbot.git/cmd.appVersion=$(VERSION)'"

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push: image
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
