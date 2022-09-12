#!/bin/bash

REPO_DIR=$(dirname $(readlink -fm "$0"))

echo $REPO_DIR

[ ! -e "${HOME}/.vim" ]       && ln -s "${REPO_DIR}/vim"         "${HOME}/.vim"       || echo ".vim already exists, skipping..."
[ ! -e "${HOME}/.vimrc" ]     && ln -s "${REPO_DIR}/vimrc"       "${HOME}/.vimrc"     || echo ".vimrc already exists, skipping..."

