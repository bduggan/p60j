#!/bin/sh

. .venv/bin/activate
export PERL6LIB=$HOME/p6-jupyter-kernel/lib
export PATH=$PATH:$HOME/p6-jupyter-kernel/bin
jupyter-notebook --no-browser ./fosdem.ipynb

