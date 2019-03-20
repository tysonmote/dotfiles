#!/bin/bash -eux

go get -u github.com/mgechev/revive
go get -u github.com/alecthomas/gometalinter
gometalinter --install

go get -u github.com/davidrjenni/reftools/cmd/fillstruct
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/dominikh/go-tools/cmd/keyify
go get -u github.com/fatih/gomodifytags
go get -u github.com/fatih/motion
go get -u github.com/golang/lint/golint
go get -u github.com/josharian/impl
go get -u github.com/jstemmer/gotags
go get -u github.com/kisielk/errcheck
go get -u github.com/klauspost/asmfmt/cmd/asmfmt
go get -u github.com/koron/iferr
go get -u github.com/stamblerre/gocode
go get -u github.com/rogpeppe/godef
go get -u github.com/vektra/mockery/...
go get -u github.com/zmb3/gogetdoc
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u golang.org/x/tools/cmd/guru
go get -u honnef.co/go/tools/cmd/megacheck

gocode exit || true
