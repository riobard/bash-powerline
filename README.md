# bash-powerline

Powerline for Bash in pure Bash script. 

![bash-powerline](https://raw.github.com/riobard/bash-powerline/master/screenshots/bash-powerline.png)

## Features

* Git branch status: display symbols when current branch is changed, and when
  the current branch is ahead/behind of remote. 
* Platform-dependent prompt symbol (see screenshots).
* Color code for the previously failed command.
* Fast execution (no noticable delay).
* No need for patched fonts. 


## Installation

Download the Bash script

    curl https://raw.github.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh

And source it in your `.bashrc`

    source ~/.bash-powerline.sh

For best result, use [Solarized
colorscheme](https://github.com/altercation/solarized) for your terminal
emulator. Or hack your own colorscheme by modifying the script. It's really
easy.


## Why?

This simple script is inspired by
[powerline-shell](https://github.com/milkbikis/powerline-shell). The problem
with powerline-shell is that it is implemented in Python, and invoking the
Python interpreter each time to draw the shell prompt involves a noticable
delay. I hate delays. So I decided to port the functionalities I need to pure
Bash script instead. 

## See also
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
