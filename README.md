# laas-ros2-courses

Présentations and list of instructions to set up courses environment.

## Environment (Nix)

This repo uses [Nix flakes](https://nixos.wiki/wiki/Flakes) to provide a ready-to-use environment, instead of asking you to install tools manually.

Nix is a package manager that builds packages in isolation, from an exact, declarative description of their dependencies. A flake is a self-contained Nix project: it lists its dependencies (`inputs`) and what it provides (`outputs`, e.g. a dev shell), and pins everything to exact versions in a `flake.lock` file, so the environment is reproducible on any machine with Nix installed.

To install Nix (if you don't have it yet), see the [official installer](https://nixos.org/download/) — make sure flakes are enabled (`experimental-features = nix-command flakes` in `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`).

Basic commands:

```bash
nix develop   # enter the dev shell; exit with `exit` or Ctrl+D
nix flake update   # re-resolve inputs to their latest versions and update flake.lock
```

## Clone all course repos

```bash
nix develop
mkdir courses && cd courses
vcs import . < ../courses.repos
```

This clones every TD/TP repo into its own subdirectory (`TD1-CLI-turtlesim/`, `TD2-code-turtlesim/`, `TP1-Tiago-overview/`, ...).

To update all of them later:

```bash
vcs pull .
```
