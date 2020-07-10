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
# - SITE_PATH
source ./env-setup.sh

# Backup element is the second argument received from the command.
# Options: all|code|files|database|db
element=$2
shift

# Pull in the functions we need.
source ./bash-functions.sh
source ./terminus-functions.sh

printf "\n"

backup "${SITE_PATH}" "${element}"

printf "\nDone!\n\n"
