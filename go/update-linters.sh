#!/bin/bash -eux

go get -u github.com/alecthomas/gometalinter
gometalinter --install --update
go get -u honnef.co/go/tools/cmd/megacheck
go get -u github.com/nsf/gocode