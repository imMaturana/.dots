#!/usr/bin/env bash

tmp_dir=$(mktemp -d)
fonts_dir=$HOME/.local/share/fonts
font='CascadiaCode'
version='3.1.0'
out="$fonts_dir/$font"

# download font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${font}.zip" -P $tmp_dir

# unzip
[ ! -d $fonts_dir ] && mkdir -p $fonts_dir
mkdir -p $out
unzip $tmp_dir/${font}.zip -d $out
