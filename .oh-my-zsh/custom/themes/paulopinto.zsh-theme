# vim:ft=zsh ts=2 sw=2 sts=2

prompt_status(){
  local -a symbols

	[[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}\u2718%{$reset_color%}"
	# [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}\u26A1%{$reset_color%}"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}\u2699%{$reset_color%}"

	[[ -n "$symbols" ]] && echo -n "$symbols "
}

prompt_context(){
  if [[ "$USER" != "paulopinto" || -n "$SSH_CLIENT" ]]; then
		echo -n "%{%F{red}%}%n@%m %{$reset_color%}"
	fi
}

prompt_aws(){
  [[ -z "$AWS_PROFILE" || "$SHOW_AWS_PROMPT" = false ]] && return

  echo -n " | %{$fg_bold[yellow]%}AWS: %{$reset_color%}"
	case "$AWS_PROFILE" in
		*prod*|*production*|*prd*)  echo -n "%{$fg_bold[red]%}$AWS_PROFILE%{$reset_color%}" ;;
		*)   echo -n "%{$fg_bold[green]%}$AWS_PROFILE%{$reset_color%}" ;;
  esac
}

prompt_git(){
  echo -n "$(git_super_status)"
}

prompt_venv(){
  [[ -n ${VIRTUAL_ENV} ]] || return
	echo -n "%{$fg_bold[yellow]%}[${VIRTUAL_ENV:t}] %{$reset_color%}"
}

prompt_time(){
	echo -n "%{$fg_bold[yellow]%}%* %{$reset_color%}"
}

prompt_path() {
    echo -n "%{$fg_bold[cyan]%}%~%{$reset_color%}"
}

prompt_cursor(){
  echo -e "\n\u25B6 "
}

prompt_newline(){
  echo ""
}

build_prompt(){
  RETVAL=$?
	prompt_newline
	prompt_status
	prompt_venv
	prompt_time
	prompt_context
	prompt_path
	prompt_git
	prompt_aws
	prompt_cursor
}

PROMPT='$(build_prompt)'
