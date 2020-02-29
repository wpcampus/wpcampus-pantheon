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
printf "\n%s\n\n" "${dev_diff}"
