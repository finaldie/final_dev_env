# Use fd/rg to replace the default find, to respect gitignore file
# export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
