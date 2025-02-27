# git aliases
alias gdefault="git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4"
alias gs="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gas="git add -A && git status"
alias gco="git checkout"
alias gnewbr="gcopm && git checkout -b"
alias gc="git commit -m"
alias gca="git commit --amend --no-edit"
alias grhh="git reset HEAD --hard"
alias grh="git reset HEAD~"
alias gpr="git pull -r && git --no-pager log -15 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)[%an]%Creset' --abbrev-commit"
alias gpo="git push -u origin HEAD"
alias gac="gas && git commit -m"
alias gsu="git stash -u"
alias gsp="git stash pop"
alias gus="git update-index --skip-worktree"
alias gusrm="git update-index --no-skip-worktree"
alias gusls="git ls-files -v | grep ^S"
alias gusada="git ls-files -m | xargs git update-index --skip-worktree"
alias gusrma="git ls-files -v | grep '^S' | cut -c 3- | xargs git update-index --no-skip-worktree"
alias gbfco="gusrma && gsu"
alias gafco="gsp && gusada"

function gdelbr() {
  main_branch=`gdefault`
  gco $main_branch && git branch | grep -v gdefault | xargs git branch -D
}

function gcopm() {
  main_branch=`gdefault`
  gco $main_branch && gpr
}

function gprom() {
  main_branch=`gdefault`
  git pull -r origin $main_branch
}

# stash, checkout and pull master, create a new branch and then pop stash.  useful for when you were running on master, made changes, and forgot to create a branch first
function gstnewbr() {
    git stash -u && gnewbr "$1" && gsp
}

# add, status, commit, pull and rebase, and push.  useful for trunk based dev, albeit you should probs be running verify before pushing
function gcpp() {
    gas && gc "$1" && gpr && gpo
}

# add, status, commit, push.  useful for PR's
function gcp() {
    gas && gc "$1" && gpo
}

# add, status, commit, push, and create a pr
function gcpr() {
    gcp "$1" && pr
}

# create new PR and open it
function pr() {
  github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@cloud:@cloud/@' -e 's@com:@com/@'  -e 's%\.git$%%' | awk '/github/'`;
  branch_name=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
  main_branch=`gdefault`
  open_or_start='open'
  uname=$(uname)
  if [[ "$uname" == CYGWIN* || "$uname" == MINGW* || "$uname" == MSYS* ]] ; then
	open_or_start='start'
  fi
  pr_url=$github_url"/compare/$main_branch..."$branch_name
  $open_or_start $pr_url
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
