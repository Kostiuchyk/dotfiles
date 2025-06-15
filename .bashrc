# git aliases
alias gdefault="git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4"
alias gs="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gas="git add -A && git status"
alias gc="git commit -m"
alias gca="git commit --amend --no-edit"
alias grf="git restore"                     # Restore a specific file
alias grs="git restore --staged"            # Unstage file
alias grall="git restore ."                 # Restore all working dir changes
alias grshh="git reset HEAD --hard"         # Discard all changes in working directory and staging area (restore to last commit)
alias grsh1="git reset HEAD~1"              # Undo last commit (soft)
alias gcln='git clean -fd'
alias gsw="git switch"
alias gnewbr="git switch -c"
alias gdelbr="git branch -D"
alias gbr="git branch"
alias gbra="git branch -a"
alias gplr="git pull -r && git --no-pager log -15 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)[%an]%Creset' --abbrev-commit"
alias gplrom="git pull -r origin $(gdefault)"
alias gpso="git push -u origin HEAD"
alias gmrs="git merge --squash"
alias gsu="git stash -u"
alias gsp="git stash pop"
alias gus="git update-index --skip-worktree"
alias gusrm="git update-index --no-skip-worktree"
alias gusls="git ls-files -v | grep ^S"
alias gusada="git ls-files -m | xargs git update-index --skip-worktree"
alias gusrma="git ls-files -v | grep '^S' | cut -c 3- | xargs git update-index --no-skip-worktree"
alias gbfco="gusrma && gsu"
alias gafco="gsp && gusada"

# Switch to main and pull latest
function gswm() {
  local main_branch=$(gdefault)
  gsw "$main_branch" && gplr
}

# Stash, create branch, and pop stash. Useful when on master you made changes instead of on specific branch
function gsunewbr() {
  gsu && git checkout -b "$1" && git stash pop
}

# Add, status, commit, push
function gcfull() {
    gas && gc "$1" && gpso
}

# general aliases
alias reload="source ~/.bashrc"
alias bashrc="code ~/.bashrc"

# docker aliases
alias dkill="docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker network prune"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dcd="docker-compose down"
alias dcu="docker-compose up"
alias dcreset="dcd && dcu"

# k8s aliases
alias k='kubectl'
