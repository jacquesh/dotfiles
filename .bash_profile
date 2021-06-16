gch() {
	branch_name="$(git branch --all | sed 's/remotes\/origin\///' | tr -d '*[:blank:]' | sort -u | fzf -q "$1")"
	git checkout $branch_name
	history -s git checkout $branch_name
}
