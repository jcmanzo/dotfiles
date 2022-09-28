# Some alias borrowed from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# Borrowed from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gitfast/gitfast.plugin.zsh
########################################
# Handle $0 according to the standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

source "${0:A:h}/git-prompt.sh"

function git_prompt_info() {
  __git_ps1 "${ZSH_THEME_GIT_PROMPT_PREFIX//\%/%%}%s${ZSH_THEME_GIT_PROMPT_SUFFIX//\%/%%}"
}
########################################

alias g="git"

alias ga="git add"
alias gaa="git add -A" # stages all changes
alias ga.="git add ."  # stages new files and modifications, without deletions
alias gau="git add -u" # stages modifications and deletions, without new files

alias gco="git checkout"
alias gcom="git checkout $(git_main_branch)"
alias gcob="git checkout -b"

alias gbr="git branch"
alias gbra="git branch -a"
alias gbrd="git branch -d"

alias gd="git diff"
alias gdc="git diff --cached"

alias gl="git log"
alias gls="git log --stat"
alias glsp="git log --stat -p"
alias glo="git log --oneline --decorate"
alias glg="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"

alias grebc="git rebase --continue"
alias greba="git rebase --abort"
alias grebi="git rebase"

function greb {
  git rebase -i HEAD~$1
}

alias gst="git status"
alias gsts="git status -s"

alias gsh="git stash"
alias gshl="git stash list"
alias gshp="git stash pop"
alias gshs="git stash save"

alias gcm="git commit -m"

alias gpsbr='git push origin "$(git_current_branch)"'
alias gpsbrf='git push --force-with-lease origin "$(git_current_branch)"'

alias gplm="git pull --rebase origin $(git_main_branch)"
alias gpl="git pull origin $(git_current_branch)"
