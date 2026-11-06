# laas-ros2-courses

Présentations and list of instructions to set up courses environment.

## Environment (Nix)

This repo uses [Nix flakes](https://nixos.wiki/wiki/Flakes) to provide a ready-to-use environment, instead of asking you to install tools manually.

Nix is a package manager that builds packages in isolation, from an exact, declarative description of their dependencies. A flake is a self-contained Nix project: it lists its dependencies (`inputs`) and what it provides (`outputs`, e.g. a dev shell), and pins everything to exact versions in a `flake.lock` file, so the environment is reproducible on any machine with Nix installed.

To install Nix (if you don't have it yet), see the [official installer](https://nixos.org/download/) — make sure flakes are enabled (`experimental-features = nix-command flakes` in `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`).

**(optional)** if you trust us, add our binary caches to avoid recompiling everything
```bash
echo 'extra-substituters = https://gepetto.cachix.org https://attic.iid.ciirc.cvut.cz/ros' | sudo tee -a /etc/nix/nix.conf

echo 'extra-trusted-public-keys = gepetto.cachix.org-1:toswMl31VewC0jGkN6+gOelO2Yom0SOHzPwJMY2XiDY= ros:JR95vUYsShSqfA1VTYoFt1Nz6uXasm5QrcOsGry9f6Q=' | sudo tee -a /etc/nix/nix.conf

# activate your new nix.conf
sudo systemctl restart nix-daemon
```

Basic commands:

```bash
nix develop   # enter the dev shell; exit with `exit` or Ctrl+D
nix flake update   # re-resolve inputs to their latest versions and update flake.lock
```

## direnv (recommended, for per-TD/TP network isolation)

In a classroom, everyone is on the same network. Without precaution, ROS 2
defaults to `ROS_DOMAIN_ID=0`, and DDS discovery (multicast) makes every
machine see every other machine — `ros2 topic list`/`ros2 node list` would
show your neighbours' nodes, and a teleop node could end up moving someone
else's robot/turtle. Some TD/TP folders ship a `.envrc` that restricts DDS
discovery to the local machine (`ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST`)
and sets a non-default `ROS_DOMAIN_ID`, loaded automatically by
[direnv](https://direnv.net/) when you `cd` into them.

This only works if direnv itself is installed **outside** of any `nix
develop` shell, with its hook active in your interactive shell from the
start — install it once, globally, before working through the TDs/TPs:

```bash
nix profile install nixpkgs#direnv
```

then add the hook to your shell's rc file (pick the line matching your
shell) and restart your terminal:

```bash
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc   # bash
echo 'eval "$(direnv hook zsh)"'  >> ~/.zshrc    # zsh
```

The first time you enter a TD/TP folder with a `.envrc`, direnv will ask
you to approve it:

```bash
direnv allow
```

You still need to run `nix develop` yourself in each new terminal — the
`.envrc` only sets a couple of lightweight environment variables, it does
not load the (much heavier) ROS dev shell.

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
