# Append the current git branch, if in a git repository
local location="%{$fg[cyan]%}%~\$(git_prompt_info)%{$reset_color%}"

# Use a % for normal users and a # for privelaged (root) users.
local prompt="%{$fg[magenta]%}%(!.#.%%)%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%} %{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[green]%}§"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$fg[green]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$fg[green]%}►"
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$fg[green]%}⑂"

# Put it all together!
PROMPT="${location} ${prompt} "
