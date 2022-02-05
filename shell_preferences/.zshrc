# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme
#source ~/.uq_aliases
source ~/.shellrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

######### AUTOSTART #########
#feh --bg-scale ~/.wallpaper 2>> /dev/null

########## ALIAS ##########
# Power management
alias hibernate="systemctl hibernate; i3lock -i ~/.lockscreen_wallpaper"
alias sleep="systemctl suspend"
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
# Git
alias gaddall='git add .'
alias gcommit='git commit -m'
alias gpull='git pull origin'
alias gpush='git push origin'
alias gstatus='git status'
# highly used terminal tools
alias f="ranger"
alias m="man"
# Pacman and yay
alias pacsyu='sudo pacman -Syyu'                 # update only standard pkgs
alias yaysua="yay -Sua --noconfirm"              # update only AUR pkgs
alias yaysyu="yay -Syu --noconfirm"              # update standard pkgs and AUR pkgs
# Get fastest mirrors
alias mirror="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
# Grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# Changing "ls" to "exa"
alias l='\ls'
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
## Top processes eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -10'
## Top processes eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -10'
# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

########## CUSTOM SHELL BINDINGS ##########
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

########## ARCHIVE EXTRACTION ##########
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
