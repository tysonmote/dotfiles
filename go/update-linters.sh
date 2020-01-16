#!/bin/bash -eux

export GO111MODULE=on

go get github.com/klauspost/asmfmt/cmd/asmfmt@latest
go get github.com/mgechev/revive@latest
go get github.com/vektra/mockery@latest
go get golang.org/x/tools/gopls@latest
go get honnef.co/go/tools/...@latest

nvim +GoUpdateBinaries +qall

