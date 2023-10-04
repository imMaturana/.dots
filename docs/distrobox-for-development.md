# Using `distrobox` to create development containers

[Distrobox](https://distrobox.it) is a command line tool that gives you the ability to run most of the Linux distribuitions in a container.

## Creating a custom [Arch Linux](https://archlinux.org) toolbox container

Dependencies needed:
- `distrobox` (obviously)
- `podman` or `docker`
- `buildah`

Distrobox offers some images to use, here we'll use the `archlinux-toolbox` image:

```
podman pull quay.io/toolbx-images/archlinux-toolbox
```

Create and enter in the container:

```
container=$(buildah from --name=setup archlinux-toolbox)
buildah run $container bash

# update and install some packages
pacman -Syyu
pacman -S zsh neovim tmux git wget fzf ripgrep
```

## Installing [Aura](https://github.com/fosskers/aura), the AUR package installer.

Arch Linux don't let the root user build packages from AUR, so we need to create a temporary user with root privileges to do that.

```
useradd tmpuser -G wheel
```

We can `exit` from this session and start a new with using temporary user:

```
buildah run --user tmpuser $container bash
```

Clone the `aura` AUR repository and install the package:

```
git clone https://aur.archlinux.org/aura-bin.git /tmp/aura-bin && cd $_
makepkg -si
```

## Installing [VSCodium](https://vscodium.com), the open source VSCode

You might be thinking "Isn't VSCode open source?" and no, the VSCode binary distributed by Microsoft isn't open source. The binary distributed by Microsoft is under a proprietary license, the source code on GitHub is under the MIT license, which gives freedom for the software be relicensed.

Of course, you can build the VSCode binary by yourself from the GitHub repository, but to avoid headaches we'll use VSCodium here.

```
aura -A vscodium-bin
```

Now that we don't need the temporary user anymore, `exit` and delete it.

```
buildah run $container userdel tmpuser
```

## Commiting the container and using the custom image

That's was easy, huh? You can now commit the container and use your custom image to create your development containers.

```
buildah commit $container $USER/archlinux-toolbox
```

To create your development container you just run:

```
distrobox create <CONTAINER NAME> -i $USER/archlinux-toolbox
```

The softwares that we installed are available in the container to use. Happy coding!
