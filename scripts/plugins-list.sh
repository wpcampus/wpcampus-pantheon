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
# - SITE_PATH
source ./env-setup.sh

# Pull in the functions we need.
source ./bash-functions.sh
source ./terminus-functions.sh

printf "\n"

${TERMINUS_BINARY} wp "${SITE_PATH}" -- plugin list --format=table

printf "\n"
