#!/bin/bash

function warn() {
   (>&2 echo $1)
}
function die(){
    echo "$1"
    exit 1
}

. ~/.venvs/userdocs/bin/activate || die "virtual env activation failed"
eval "$(rbenv init -)" || die "rbenv failed"
pip install -r requirements.txt || die "pip install failed"
mkdocs build --strict || die "mkdocs build failed"
./htmlproof.sh || warn "HTMLProofer failed"
mkdocs serve --dev-addr 127.0.0.1:8001
