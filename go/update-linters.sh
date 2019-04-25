#!/bin/bash -eux

go get -u github.com/mgechev/revive
go get -u github.com/klauspost/asmfmt/cmd/asmfmt
go get -u github.com/vektra/mockery/...
go get -u honnef.co/go/tools/cmd/megacheck

nvim +GoUpdateBinaries +qall

