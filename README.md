# bash-powerline

Powerline for Bash in pure Bash script. 


## Features

* Git branch: display current git branch name, or short SHA1 hash when the head is detached
* Git branch: display "+" symbol when current branch is changed but uncommited
* Git branch: display "⇡" symbol and the difference in the number of commits when the current branch is ahead of remote
* Git branch: display "⇣" symbol and the difference in the number of commits when the current branch is behind of remote
* Username displayed
* Hostname displayed only when SSH'd
* Color code for root
* Color code for sudo session
* Color code for the previously failed command
* Directory shortening ('/some/.../long/path')
* Fast execution (no noticable delay)
* No need for patched fonts


## Installation

Download the Bash script

    curl -L https://raw.github.com/napalm255/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh

And source it in your `.bashrc`

    source ~/.bash-powerline.sh

