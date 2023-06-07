#
#         ░█▀█░█░░░▀█▀░█▀█░█▀▀░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
#         ░█▀█░█░░░░█░░█▀█░▀▀█░░░▀▀█░█▀▀░░█░░█░█░█▀▀
#         ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░
#
# shellcheck shell=zsh

alias 'vol'='alsamixer'
alias 'v'='nvim'
alias 'ssh-keyless'='ssh -o PasswordAuthentication=yes -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no'
alias 'sudo'='sudo '

#
# Bultin alternatives
#

if command -v bat > /dev/null; then
	alias 'cat'='bat'
fi

if command -v exa > /dev/null; then
	alias 'ls'='exa'
fi

if command -v dig > /dev/null; then
	alias 'dig'='dog'
fi

#
# Git aliases
#

alias 'g'='git'

git_current_branch() {
	ref="$(GIT_OPTIONAL_LOCKS=0 command git symbolic-ref --quiet HEAD 2> /dev/null)"
	ret="${?}"

	if [ "${ret}" != '0' ]; then
		if [ "${ret}" = '128' ]; then
			unset ref
			unset ret

			return # no git repo
		fi

		ref="$(GIT_OPTIONAL_LOCKS=0 command git rev-parse --short HEAD 2> /dev/null)" || return
	fi

	echo "${ref#refs/heads/}"

	unset ref
	unset ret
}

git_main_branch() {
	command git rev-parse --git-dir >/dev/null 2>&1 || return

	for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
		if command git show-ref -q --verify "${ref}"; then
			echo "${ref:t}"
			unset ref
			return
		fi
	done

	unset ref
	echo master
}

function git_dev_branch() {
	local branch
	command git rev-parse --git-dir &>/dev/null || return

	for branch in dev devel development; do
		if command git show-ref -q --verify "refs/heads/${branch}"; then
			echo "${branch}"
			return
		fi
	done

	echo develop
}

alias 'ga'='git add'
alias 'ga!'='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add'
alias 'gaa'='git add --all'
alias 'gap'='git add --patch'
alias 'gau'='git add --update'
alias 'gav'='git add --verbose'

alias 'gapp'='git apply'
alias 'gap3'='git apply --3way'

alias 'gb'='git branch'
alias 'gba'='git branch -a'
alias 'gbd'='git branch -d'
alias 'gbda'='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
alias 'gbD'='git branch -D'
alias 'gbnm'='git branch --no-merged'
alias 'gbr'='git branch --remote'

gbR() {
	if [[ -z "${1}" || -z "${2}" ]]; then
		echo "Usage: ${0} <old branch> <new branch>"
		return 1
	fi

	git branch -m "${1}" "${2}" # Rename branch locally

	if git push origin :"${1}"; then
		git push --set-upstream origin "${2}" # Rename branch in origin remote
	fi
}

alias 'gbl'='git blame -b -w'

alias 'gbs'='git bisect'
alias 'gbsb'='git bisect bad'
alias 'gbsg'='git bisect good'
alias 'gbsr'='git bisect reset'
alias 'gbss'='git bisect start'

alias 'gcl'='git clone --recurse-submodules'

alias 'gc'='git commit -v'
alias 'gc!'='git commit -v --amend'
alias 'gc!!'='git commit -v --amend --no-edit'
alias 'gcn'='git commit -v --no-edit'
alias 'gcn!'='git commit -v --no-edit --amend'
alias 'gca'='git commit -v -a'
alias 'gca!'='git commit -v -a --amend'
alias 'gcan!'='git commit -v -a --amend --no-edit'
alias 'gcans!'='git commit -v -a -s --amend --no-edit'
alias 'gcam'='git commit -a -m'
alias 'gcsm'='git commit -s -m'
alias 'gcas'='git commit -a -s'
alias 'gcasm'='git commit -a -s -m'
alias 'gcf'='git commit -v --fixup'
alias 'gcm'='git commit -m'
alias 'gcs'='git commit -S'
alias 'gcss'='git commit -S -s'
alias 'gcssm'='git commit -S -s -m'

alias 'gcb'='git checkout -b'
alias 'gco'='git checkout'
alias 'gcod'='git checkout $(git_dev_branch)'
alias 'gcom'='git checkout $(git_main_branch)'
alias 'gcor'='git checkout --recurse-submodules'

alias 'gd'='git diff'
alias 'gd!'='git ls-files --exclude-standard | fzf -m --print0 | xargs -0 -o -t git diff'
alias 'gd!!'='git ls-files --exclude-standard -m | fzf -m --print0 | xargs -0 -o -t git diff'
alias 'gdca'='git diff --cached'
alias 'gdcw'='git diff --cached --word-diff'
alias 'gds'='git diff --staged'
alias 'gdu'='git diff @{upstream}'
alias 'gdw'='git diff --word-diff'

alias 'gf'='git fetch'
alias 'gfa'='git fetch --all --prune --jobs=10'
alias 'gfo'='git fetch origin'

alias 'gl'='git pull'
alias 'glr'='git pull --rebase'
alias 'glra'='git pull --rebase --autostash'

alias 'glg'='git log --stat'
alias 'glp'='git log --stat -p'
alias 'glo'='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias 'glop'='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --patch'
alias 'glos'='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias 'glops'='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --patch --stat'

alias 'gm'='git merge '
alias 'gma'='git merge --abort'

alias 'gp'='git push'
alias 'gpd'='git push --dry-run'
alias 'gp!'='git push --force-with-lease'
alias 'gp!!'='git push --force'

alias 'gr'='git remote'
alias 'gra'='git remote add'
alias 'grrn'='git remote rename'
alias 'grrm'='git remote remove'
alias 'grsu'='git remote set-url'
alias 'gru'='git remote update'
alias 'grv'='git remote -v'

alias 'grt'='cd "$(git rev-parse --show-toplevel || echo .)"'

alias 'grb'='git rebase'
alias 'grba'='git rebase --abort'
alias 'grbc'='git rebase --continue'
alias 'grbc!'='GIT_EDITOR=true git rebase --continue'
alias 'grbi'='git rebase -i'
alias 'grbd'='git rebase $(git_dev_branch)'
alias 'grbm'='git rebase $(git_main_branch)'
alias 'grbo'='git rebase --onto'
alias 'grbs'='git rebase --skip'

alias 'grh'='git reset'
alias 'grhh'='git reset --hard'
alias 'grho'='git reset origin/$(git_current_branch) --hard'

alias 'grm'='git rm'
alias 'grmc'='git rm --cached'

alias 'gsu'='git stash push'
alias 'gsa'='git stash apply'
alias 'gsc'='git stash clear'
alias 'gsd'='git stash drop'
alias 'gsl'='git stash list'
alias 'gsp'='git stash pop'
alias 'gss'='git stash show'
alias 'gsps'='git stash list --stat --patch'

alias 'gsb'='git status -sb'

alias 'gw'='git worktree'
alias 'gwa'='git worktree add'
alias 'gwl'='git worktree list'
alias 'gwmv'='git worktree move'
alias 'gwrm'='git worktree remove'
