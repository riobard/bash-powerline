# bash-powerline

Powerline for Bash in pure Bash script. 


## Features

* Git branch: display current git branch name, or short SHA1 hash when the head is detached
* Git branch: display "+" symbol when current branch is changed but uncommited
* Git branch: display "⇡" symbol and the difference in the number of commits when the current branch is ahead of remote (see screenshot)
* Git branch: display "⇣" symbol and the difference in the number of commits when the current branch is behind of remote (see screenshot)
* Color code for the previously failed command
* Fast execution (no noticable delay)
* No need for patched fonts


## Installation

Download the Bash script

    curl -L https://raw.github.com/napalm255/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh

And source it in your `.bashrc`

    source ~/.bash-powerline.sh

