export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH

if [ ! -d /go ]; then
	echo "Please, create /go directory."
fi
