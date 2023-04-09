#!/bin/bash -eux

go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/klauspost/asmfmt/cmd/asmfmt@latest
go install github.com/mgechev/revive@latest
go install golang.org/x/tools/gopls@latest
go install honnef.co/go/tools/...@latest

nvim +GoUpdateBinaries +qall
