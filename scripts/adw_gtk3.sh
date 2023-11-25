#!/usr/bin/env bash

tmp_dir=$(mktemp -d)
themes_dir=$HOME/.local/share/themes
version='5.1'

wget "https://github.com/lassekongo83/adw-gtk3/releases/download/v${version}/adw-gtk3v${version//./-}.tar.xz" -P $tmp_dir

[ ! -d $themes_dir ] && mkdir -p $themes_dir
tar xvf "$tmp_dir/adw-gtk3v${version//./-}.tar.xz" -C $themes_dir
