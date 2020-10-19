#!/bin/bash

REPO_DIR=$(dirname $(readlink -fm "$0"))

echo $REPO_DIR

[ ! -e "${REPO_DIR}/.vim" ]       && ln -s "${REPO_DIR}/vim"         "${HOME}/.vim"
[ ! -e "${REPO_DIR}/.vimrc" ]     && ln -s "${REPO_DIR}/vimrc"       "${HOME}/.vimrc"

