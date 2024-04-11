APP=${basename $(git remote get-url origin)}
REGISTRY=peperd
VERSION= ${shell git describe --tags --abbrev=0 }-${shell git rev-parse --short HEAD}
TARGETOS=linux 
TARGETARCH=arm64

linux:
	TARGETOS=linux TARGETARCH=arm64

windows:
	TARGETOS=windows TARGETARCH=amd64

macOS:
	TARGETOS=darwin TARGETARCH=amd64

macOSARM:
	TARGETOS=darwin TARGETARCH=arm64

format:
	gofmt -s -w ./

gocritic:
	gocritic check ./...

test:
	go test -v  

get:
	go get

build: format get
	GO_VERSION=1.20
	export GO_VERSION
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot.git -ldflags "-X="github.com:peperd/kbot.git/cmd.appVesion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot.git	 