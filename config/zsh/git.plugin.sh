#
#          ░█▀▀░▀█▀░▀█▀
#          ░█░█░░█░░░█░
#          ░▀▀▀░▀▀▀░░▀░
#
# shellcheck shell=sh

alias 'g'='git'

_dot_git_current_branch() (
	ref="$(GIT_OPTIONAL_LOCKS=0 command git symbolic-ref --quiet HEAD 2> /dev/null)"
	ret="${?}"

	if [ "${ret}" != '0' ]; then
		if [ "${ret}" = '128' ]; then
			return # not a git repository
		fi

		ref="$(GIT_OPTIONAL_LOCKS=0 command git rev-parse --short HEAD 2> /dev/null)" || return
	fi

	echo "${ref#refs/heads/}"
)

_dot_git_main_branch() (
	_dot_void command git rev-parse --git-dir || return

	refs='refs/heads/main refs/heads/trunk'

	for remote in $(command git remote --no-verbose); do
		for branch in main trunk; do
			refs="${refs} refs/remotes/${remote}/${branch}"
		done
	done

	for ref in $(_dot_split "${refs}" ' '); do
		if command git show-ref -q --verify "${ref}"; then
			echo "${ref##*/}"
			return
		fi
	done

	echo master
)

_dot_git_dev_branch() (
	command git rev-parse --git-dir >/dev/null 2>&1 || return

	for branch in dev devel development; do
		if command git show-ref -q --verify "refs/heads/${branch}"; then
			echo "${branch}"
			return
		fi
	done

	echo develop
)

_dot_git_super_add() {
	git ls-files --deleted --modified --other --exclude-standard \
		| fzf --exit-0 --multi --print0 --preview 'git diff --color=always {-1}' \
		| xargs -r0 git add
}

_dot_git_super_add_patch() {
	# No need to be so strict here.
	# shellcheck disable=2312,2046
	git add --patch $(
		git ls-files --deleted --modified --other --exclude-standard \
		| fzf --exit-0 --multi --preview 'git diff --color=always {-1}'
	)
}

alias 'ga'='git add'
alias 'ga!'='_dot_git_super_add'
alias 'gaa'='git add --all'
alias 'gap'='git add --patch'
alias 'gap!'='_dot_git_super_add_patch'
alias 'gau'='git add --update'
alias 'gav'='git add --verbose'

alias 'gapp'='git apply'
alias 'gap3'='git apply --3way'

alias 'gb'='git branch'
alias 'gba'='git branch -a'
alias 'gbd'='git branch -d'
alias 'gbda'='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(_dot_git_main_branch)|$(_dot_git_dev_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
alias 'gbD'='git branch -D'
alias 'gbnm'='git branch --no-merged'
alias 'gbr'='git branch --remote'
alias 'gbup'='git branch --set-upstream-to origin/$(_dot_git_current_branch) $(_dot_git_current_branch)'

gbR() {
	if [ -z "${1}" ] || [ -z "${2}" ]; then
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

_dot_git_super_fixup() {
	command git log --oneline --no-decorate --no-merges \
		| fzf --exit-0 --preview 'git show --color=always --format=oneline {1}' \
		| cut -d' ' -f1 \
		| xargs -r git commit -v "${@}" --fixup
}

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
alias 'gcf!'='_dot_git_super_fixup'
alias 'gcm'='git commit -m'
alias 'gcs'='git commit -S'
alias 'gcss'='git commit -S -s'
alias 'gcssm'='git commit -S -s -m'

# Prepare a commit message.
gprep () {
	msgfile="$(git rev-parse --git-dir)/COMMIT_WIPMSG"

	if [ ! -f "${msgfile}" ]
	then
		template="$(git config --get commit.template)"

		if [ "${template}" != '' ]
		then
			case "${template}" in
				'~/'*) template="${HOME}/${template##\~/}" ;;
				*) ;;
			esac

			cp "${template}" "${msgfile}"
		fi

		unset template
	fi

	"${EDITOR:-vi}" "${msgfile}"

	unset msgfile
}

# Commit with a prepared message.
gcprep () {
	msgfile="$(git rev-parse --git-dir)/COMMIT_WIPMSG"

	if [ -f "${msgfile}" ]
	then
		if git commit -e -F "${msgfile}" "${@}"
		then
			rm "${msgfile}"
		fi
	else
		echo 'No prepared message found, falling back to regular git commit.'
		git commit "${@}"
	fi

	unset msgfile
}

alias 'gcb'='git checkout -b'
alias 'gco'='git checkout'
alias 'gcod'='git checkout $(_dot_git_dev_branch)'
alias 'gcom'='git checkout $(_dot_git_main_branch)'
alias 'gcor'='git checkout --recurse-submodules'

alias 'gd'='git diff'
alias 'gd!'='git ls-files --exclude-standard | fzf -m --print0 | xargs -0 -o -t git diff'
alias 'gd!!'='git ls-files --exclude-standard -m | fzf -m --print0 | xargs -0 -o -t git diff'
alias 'gdca'='git diff --cached'
alias 'gdcw'='git diff --cached --word-diff'
alias 'gds'='git diff --staged'
alias 'gdt'='git diff-tree --no-commit-id --name-only -r'
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
alias 'glo'='git log --graph --pretty="%C(green)%h%C(reset) - %s %C(cyan)<%an> %C(reset)%C(blue)%ar%C(red)%d%C(reset)" --all'
alias 'glop'='git log --graph --pretty="%C(green)%H%C(red)%d%n%C(bold)%C(reset)%C(cyan)%an <%ae>%n%C(reset)%C(blue)%ai (%ar)%C(reset)%n%+B" --patch'
alias 'glos'='git log --graph --pretty="%C(green)%H%C(red)%d%n%C(bold)%C(reset)%C(cyan)%an <%ae>%n%C(reset)%C(blue)%ai (%ar)%C(reset)%n%+B" --stat'
alias 'glops'='git log --graph --pretty="%C(green)%H%C(red)%d%n%C(bold)%C(reset)%C(cyan)%an <%ae>%n%C(reset)%C(blue)%ai (%ar)%C(reset)%n%+B" --patch --stat'

alias 'gm'='git merge '
alias 'gma'='git merge --abort'
alias 'gmm'='git merge $(_dot_git_main_branch)'
alias 'gmd'='git merge $(_dot_git_dev_branch)'
alias 'gmt'='git mergetool'

alias 'gp'='git push'
alias 'gpp'='git push origin $(_dot_git_current_branch)'
alias 'gpup'='git push --set-upstream origin $(_dot_git_current_branch)'
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

alias 'groot'='cd "$(git rev-parse --show-toplevel || echo .)"'

alias 'grb'='git rebase'
alias 'grba'='git rebase --abort'
alias 'grbc'='git rebase --continue'
alias 'grbc!'='GIT_EDITOR=true git rebase --continue'
alias 'grbe'='git rebase --edit-todo'
alias 'grbi'='git rebase -i'
alias 'grbis'='git rebase -i --autosquash'
alias 'grbd'='git rebase $(_dot_git_dev_branch)'
alias 'grbm'='git rebase $(_dot_git_main_branch)'
alias 'grbo'='git rebase --onto'
alias 'grbs'='git rebase --skip'

alias 'gcp'='git cherry-pick'
alias 'gcpa'='git cherry-pick --abort'
alias 'gcpc'='git cherry-pick --continue'

alias 'grh'='git reset'
alias 'grhh'='git reset --hard'
alias 'grho'='git reset origin/$(_dot_git_current_branch) --hard'

alias 'grm'='git rm'
alias 'grmc'='git rm --cached'

_dot_git_super_stash_pop() {
	git stash list \
		| fzf --exit-0 --preview 'git show --pretty=oneline --color=always --patch "$(echo {} | cut -d: -f1)"' \
		| cut -d: -f1 \
		| xargs -r git stash pop
}

alias 'gsu'='git stash push'
alias 'gsa'='git stash apply'
alias 'gsc'='git stash clear'
alias 'gsd'='git stash drop'
alias 'gsl'='git stash list --pretty="%C(yellow)%gd%C(reset): %C(green)%cr %C(reset)%s"'
alias 'gslp'='git stash list --patch'
alias 'gsp'='git stash pop'
alias 'gsp!'='_dot_git_super_stash_pop'
alias 'gss'='git stash show'
alias 'gssp'='git stash show --patch'
alias 'gsps'='git stash list --stat --patch'

alias 'gs'='git status --untracked-files=no'
alias 'gs!'='git status'
alias 'gsb'='git status -sb'

alias 'gw'='git worktree'
alias 'gwa'='git worktree add'
alias 'gwl'='git worktree list'
alias 'gwmv'='git worktree move'
alias 'gwrm'='git worktree remove'

alias 'gfp'='git format-patch'
alias 'gfpc'='git format-patch --cover-letter'
alias 'gsm'='git send-email'
