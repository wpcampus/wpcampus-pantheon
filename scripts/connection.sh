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

# Mode is the first argument received from the command.
connection_mode=$1
shift

# Confirm we have a connection mode.
if [[ -z "${connection_mode}" ]]; then
  printf "\nYou must provide the connection mode: git or sftp.\n\n"
  exit 1
fi

# Confirm we have a valid connection mode.
if [[ "${connection_mode}" != "git" ]] && [[ "${connection_mode}" != "sftp" ]]; then
  printf "\nYou must provide a valid connection mode: git or sftp.\n\n"
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

connection "${SITE_PATH}" "${connection_mode}"

printf "\nDone!\n\n"
