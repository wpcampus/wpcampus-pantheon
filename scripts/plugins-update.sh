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

# Make sure we have all the environment information we need.
# Defines the following variables that we need:
# - TERMINUS_BINARY
# - PANTHEON_EMAIL
# - SITE_PATH
source ./env-setup.sh

# Pull in the functions we need.
source ./bash-functions.sh
source ./terminus-functions.sh

# Converts SITE_NAME to a CSV array which allows
# for multiple sites to be processed at the same time.
export IFS=","
for site in $SITE_NAME; do

  display_header "Pinging the ${site} ${ENV_NAME} environment"

  # The SITE_NAME is the first argument received from the command.
  SITE_PATH="${site}.${ENV_NAME}"

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
  confirm_message "Are you sure you want to update these plugins in the ${site} ${ENV_NAME} environment?\nMake sure the Pantheon environment is set to SFTP mode."

  printf "\nUpdating plugins in the %s %s environment...\n\n" "${site}" "${ENV_NAME}"

  commit_message=$(${TERMINUS_BINARY} wp "${SITE_PATH}" -- plugin update --all --format=table --quiet --require=hide_php_errors.php)

  printf "\nThe following plugins were updated in the %s %s environment:" "${site}" "${ENV_NAME}"
  printf "\n%s\n" "${commit_message}"

  # Ask for commit confirmation.
  confirm_message "Do you want to commit these changes to the ${site} ${ENV_NAME} environment?"

  printf "\n"

  commit_code "${SITE_PATH}" "${commit_message}"

  printf "\n"

  clear_cache "${SITE_PATH}"
done

printf "\nFYI: The plugin code has only been updated in the defined environments."
printf "\n\nAfter you've tested the %s environment(s), you will have to deploy the code updates to the TEST and PROD environment(s)." "${ENV_NAME}"
printf "\n\n"
