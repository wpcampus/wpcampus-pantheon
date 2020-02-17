###
# This script requires:
# - Access to the site's Pantheon Dashboard
# - Terminus, Pantheon's CLI (https://pantheon.io/docs/terminus)
# - An .env file which has your Pantheon email.
#
# - The hide_php_errors.php file located in the repo's "files_for_pantheon" directory
#   must be placed in the main "code" directory on the Pantheon dev server.
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
source ./bash-functions.sh
source ./terminus-functions.sh

auth "${PANTHEON_EMAIL}"
wake_env "${SITE_PATH}"

printf "\nChecking to see if any plugins need an update...\n\n"

# TODO: optimize to parse CSV into an array and not have to run WPCLI plugin list multiple times?
plugins_update_count=$(${TERMINUS_BINARY} wp "${SITE_PATH}" -- plugin list --format=count --update=available)

if [[ "0" == ${plugins_update_count} ]]; then
  plugins_table=$(${TERMINUS_BINARY} wp "${SITE_PATH}" -- plugin list --format=table)
  printf "\nThere are no plugins with an update available.\n%s\n\n" "${plugins_table}"
  exit 0
fi

# TODO: optimize to parse CSV into an array and not have to run WPCLI plugin list multiple times?
plugins_update_table=$(${TERMINUS_BINARY} wp "${SITE_PATH}" -- plugin list --format=table --update=available)

printf "\nThe following plugins have an update available:\n%s\n" "${plugins_update_table}"

# Ask for update confirmation.
confirm_message "Are you sure you want to update these plugins to their current version?\nMake sure the Pantheon environment is set to SFTP mode."

printf "\nTime to update some plugins...\n\n"

commit_message=$(${TERMINUS_BINARY} wp "${SITE_PATH}" -- plugin update --all --format=table --quiet --require=hide_php_errors.php --exclude=google-analytics-for-wordpress/googleanalytics.php,google-analytics-dashboard-for-wp/gadwp.php)

printf "\nThe following plugins were updated on the dev environment:"
printf "\n%s\n" "${commit_message}"

# Ask for commit confirmation.
confirm_message "Do you want to commit these changes to the dev environment?"

printf "\n"

commit_code "${SITE_PATH}" "${commit_message}"
clear_cache "${SITE_PATH}"

printf "\nFYI: The plugin code has only been updated on the Pantheon dev environment."
printf "\n\nAfter you've tested the dev environment to ensure the updates didn't create issues, you will then have to manually commit the code updates to PROD inside the Pantheon Dashboard."
printf "\n\n"
