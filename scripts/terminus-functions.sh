# Authenticates the user's local machine with their Pantheon account
# Pass the Pantheon email as the first variable.
auth() {
  ${TERMINUS_BINARY} auth:login --email="$1"
}

# Commits the current changes to the dev environment.
# Pass the site path as the first variable.
# Pass the commit message as the second variable.
commit_to_dev() {
  ${TERMINUS_BINARY} env:commit --message "$2" -- "$1"
}

# Wakes the site environment.
# Pass the site path as the first variable.
wake_env() {
  ${TERMINUS_BINARY} env:wake "$1"
}
