#!/usr/bin/env bash

tmp_dir=$(mktemp -d)
themes_dir=$HOME/.local/share/themes
theme='Catppuccin-Mocha-Standard-Blue-Dark'
version='0.7.0'

# download package
wget "https://github.com/catppuccin/gtk/releases/download/v${version}/${theme}.zip" -P $tmp_dir

# unzip
[ ! -d $themes_dir ] && mkdir -p $themes_dir
unzip $tmp_dir/$theme.zip -d $themes_dir

