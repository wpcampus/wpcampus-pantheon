###
# This script requires:
# - Access to the site's Pantheon Dashboard
# - Terminus, Pantheon's CLI (https://pantheon.io/docs/terminus)
# - An .env file which has your Pantheon email.
#
# See the README for more information.
###

# Make sure we have all the environment information we need.
# Defines the following variables that we need:
# - TERMINUS_BINARY
# - PANTHEON_EMAIL
# - SITE_PATH
source ./env-setup.sh

# Note is the third argument received from the command.
NOTE=$3
shift

# Confirm we have a note.
if [[ -z "${NOTE}" ]]; then
  printf "\nA note describing the deploy is required to run this script.\n\nCommand: %s [site_name] [environment] \"I'm a note about the deploy\"" "$0"
  printf "\n\nExample: %s heweb16 %s \"Updating plugins\"\n\n" "$0" "${ENV_NAME}"
  exit 1
fi

# Pull in the functions we need.
source ./bash-functions.sh
source ./terminus-functions.sh

wake_env "${SITE_PATH}"

printf "\n"

# Ask for confirmation.
confirm_message "Are you sure you want to deploy to the ${ENV_NAME} environment?"

printf "\n"

deploy "${SITE_PATH}" "${NOTE}"

printf "\n"

clear_cache "${SITE_PATH}"

printf "\n"
