# Authenticates the user's local machine with their Pantheon account
# Pass the Pantheon email as the first variable.
auth() {
  ${TERMINUS_BINARY} auth:login --email="$1"
}

# Commits the current changes to a site path.
# Order of variables:
# 1. The site path, e.g. sitename.dev
# 2. The commit message
commit_code() {
  ${TERMINUS_BINARY} env:commit --message "$2" -- "$1"
}

# Wakes the site environment.
# Pass the site path as the first variable, e.g. sitename.dev.
wake_env() {
  ${TERMINUS_BINARY} env:wake "$1"
}

# Clears caches for the Pantheon environment.
# Pass the site path as the first variable, e.g. sitename.dev.
clear_cache() {
  ${TERMINUS_BINARY} env:clear-cache "$1"
}

# Sets Git or SFTP connection mode on a development environment
# Excludes Test and Live.
connection() {
  ${TERMINUS_BINARY} connection:set "$1" "$2"
}

# Deploys code to a Pantheon environment.
# Pass the site path as the first variable, e.g. sitename.dev.
deploy() {
  ${TERMINUS_BINARY} env:deploy "$1" --note "$2"
}

# Creates a backup of a Pantheon environment.
# Pass the site path as the first variable, e.g. sitename.dev.
backup() {

  element_default="all"

  # If no element is provided, set default.
  if [[ -z "${2}" ]]; then
    element="${element_default}"
  else

    element_options=("all" "code" "files" "database" "db")

    # If not one of element options, set default.
    if [[ ! ${element_options[*]} =~ ${2} ]]; then
      element="${element_default}"
    else
      element="${2}"
    fi
  fi

  ${TERMINUS_BINARY} backup:create "$1" --element="${element}"
}