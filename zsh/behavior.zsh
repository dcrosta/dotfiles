# TODO: incorporate completion

#
# execution

export reporttime=5 # report timing for any command longer than 5 seconds


#
# history

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_all_dups
setopt hist_verify
setopt hist_reduce_blanks
setopt append_history

#
# correction

setopt nocorrect

#
# term support

# set term title appropriately based on term type
# user@host:current_dir (current_command)
case "$TERM" in
  xterm*|rxvt*)
    term_preexec () {
      print -Pn "\e]0;%n@%m:%~ ($1)\a"  # xterm
    }
    term_precmd () {
      print -Pn "\e]0;%n@%m:%~\a"  # xterm
    }
    ;;
  screen*)
    term_preexec () {
      local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]}
      echo -ne "\ek$CMD\e\\"
      print -Pn "\e]0;%n@%m:%~ ($1)\a"  # xterm
    }
    term_precmd () {
      echo -ne "\ekzsh\e\\"
      print -Pn "\e]0;%n@%m:%~\a"  # xterm
    }
    ;;
esac
