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

# Make sure we have all the environment information we need.
# Defines the following variables that we need:
# - TERMINUS_BINARY
# - PANTHEON_EMAIL
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

  printf "\n"

  ${TERMINUS_BINARY} wp "${SITE_PATH}" -- plugin list --format=table
done

printf "\n"
