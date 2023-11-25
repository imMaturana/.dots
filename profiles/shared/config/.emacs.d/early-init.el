;; -*- lexical-binding: t -*-

(progn ; disable some stuff
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  ;; disable welcome buffer
  (setq inhibit-startup-message t)

  ;; enable truncate lines
  (setq truncate-lines t))

(progn ; fonts
  (set-face-attribute 'default nil :font "CaskaydiaCove Nerd Font Mono")

  ;; emacs client
  (add-to-list 'default-frame-alist '(font . "CaskaydiaCove Nerd Font Mono-10")))

(progn ; line numbers
  (global-display-line-numbers-mode))
