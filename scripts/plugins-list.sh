###
# This script requires:
# - Access to the site's Pantheon Dashboard
# - Terminus, Pantheon's CLI (https://pantheon.io/docs/terminus)
# - An .env file which has your Pantheon email.
#
# See the README for more information.
###

# Will always be dev because that's the only environment where we can update plugins.
ENV_NAME="dev"

# Is received from command.
SITE_NAME=$1
shift

# Confirm we have a site name.
if [[ -z "${SITE_NAME}" ]]; then
  printf "\nA site name is required to run this script.\n\nCommand: %s <site_name>\n\nExample: %s heweb16\n\nThe site name is the name displayed at the top of the Pantheon Dashboard.\n\n" "$0" "$0"
  exit 1
fi

# Make sure we have all the environment information we need.
source ./env-check.sh

# The SITE_NAME is pulled from the .env file.
SITE_PATH="${SITE_NAME}.${ENV_NAME}"

# Pull in the functions we need.
source ./terminus-functions.sh

auth "${PANTHEON_EMAIL}"
wake_env "${SITE_PATH}"

printf "\n"

${TERMINUS_BINARY} wp "${SITE_PATH}" -- plugin list --format=table

printf "\n"
