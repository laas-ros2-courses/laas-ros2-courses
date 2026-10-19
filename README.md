# laas-ros2-courses

Présentations and list of instructions to set up courses environment.

## Clone all course repos at once

This repo doesn't contain the TD/TP content itself — each TD/TP lives in its own repo under the [laas-ros2-courses](https://github.com/laas-ros2-courses) organization, listed in [`courses.repos`](courses.repos).

```bash
pip install vcstool  # or: nix-shell -p python3Packages.vcstool
mkdir courses && cd courses
vcs import . < ../courses.repos
```

This clones every TD/TP repo into its own subdirectory (`TD1-CLI-turtlesim/`, `TD2-code-turtlesim/`, `TP1-Tiago-overview/`, ...).

To update all of them later:

```bash
vcs pull .
```
