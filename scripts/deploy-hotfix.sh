###
# This script requires:
# - Access to the site's Pantheon Dashboard
# - Terminus, Pantheon's CLI (https://pantheon.io/docs/terminus)
# - An .env file which has your Pantheon email.
#
# See the README for more information.
###

# Always goes to dev.
ENV_NAME="dev"

# The commit message is the second argument received from the command.
commit_message=$1
shift

# Confirm we have a commit message.
if [[ -z "${commit_message}" ]]; then
  printf "\nA commit message is required to run this script.\n\nCommand: %s \"I'm a commit message\"" "$0"
  printf "\n\nExample: %s %s \"Updating plugins\"\n\n" "$0" "${ENV_NAME}"
  exit 1
fi

# Make sure we have all the environment information we need.
# Defines the following variables that we need:
# - TERMINUS_BINARY
# - SITE_PATH
source ./env-setup.sh

# Pull in the functions we need.
source ./bash-functions.sh
source ./terminus-functions.sh

printf "\n"

# Gets the diff of uncommitted code changes on the dev environment.
dev_diff=$(${TERMINUS_BINARY} env:diffstat "${SITE_PATH}")

printf "\nThe following code changes are present on the %s %s environment:" "${ORG_LABEL}" "${ENV_NAME}"
printf "\n%s\n" "${dev_diff}"

# Ask for confirmation.
confirm_message "Are you sure you want to deploy to the ${ORG_LABEL} production environment?"

printf "\n"

commit_code "${SITE_PATH}" "${commit_message}"
clear_cache "${SITE_PATH}"

printf "\n"

TEST_PATH="${SITE_NAME}.test"
deploy "${TEST_PATH}" "${commit_message}"
clear_cache "${TEST_PATH}"

printf "\n"

LIVE_PATH="${SITE_NAME}.live"
deploy "${LIVE_PATH}" "${commit_message}"
clear_cache "${LIVE_PATH}"

printf "\nDone!\n\n"
