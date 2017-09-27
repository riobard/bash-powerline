# bash-powerline

Powerline for Bash in pure Bash script.

![bash-powerline](https://raw.github.com/riobard/bash-powerline/master/screenshots/solarized-light.png)

## Features

* Git: show branch name, tag name, or unique short hash.
* Git: show "*" symbol with uncommited modifications.
* Git: show "↑" symbol and number of commits ahead of remote.
* Git: show "↓" symbol and number of commits behind remote.
* Platform-dependent prompt symbols.
* Color-coded prompt symbol according to previous command execution status.
* Use Bash builtin when possible to reduce delay. Delay sucks!
* No need for patched fonts.


## Installation

Download the Bash script

    curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh

And source it in your `.bashrc`

    source ~/.bash-powerline.sh

For best result, use [Solarized
colorscheme](https://github.com/altercation/solarized) for your terminal
emulator. Or hack your own colorscheme by modifying the script. It's really
easy.


## Why?

This script is inspired by
[powerline-shell](https://github.com/milkbikis/powerline-shell), which is
implemented in Python. Python scripts are much easier to write and maintain than
Bash scripts, but invoking Python interpreter introduces noticable delay to
draw. I hate delays, so I ported just the part I need to pure Bash script.

The other reason is that I don't like the idea of patching fonts. The
font patching mechanism from the original Powerline does not work with the
bitmap font (Apple Monaco without anti-aliasing) I use on non-retina screens.
I'd rather stick with existing unicode symbols.


## See also

* [zsh-powerline](https://github.com/riobard/zsh-powerline): Same thing but for
    Zsh.
* [powerline](https://github.com/Lokaltog/powerline): Unified Powerline
  written in Python. This is the future of all Powerline derivatives.
* [vim-powerline](https://github.com/Lokaltog/vim-powerline): Powerline in Vim
  writtien in pure Vimscript. Deprecated.
* [tmux-powerline](https://github.com/erikw/tmux-powerline): Powerline for Tmux
  written in Bash script. Deprecated.
* [powerline-shell](https://github.com/milkbikis/powerline-shell): Powerline for
  Bash/Zsh/Fish implemented in Python. Might be merged into the unified
  Powerline.
* [emacs powerline](https://github.com/milkypostman/powerline): Powerline for
  Emacs
