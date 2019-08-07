#!/bin/bash -eux

export GO111MODULE=off

go get -u github.com/klauspost/asmfmt/cmd/asmfmt
go get -u github.com/mgechev/revive
go get -u github.com/vektra/mockery
go get -u golang.org/x/tools/cmd/gopls
go get -u honnef.co/go/tools/...

nvim +GoUpdateBinaries +qall

