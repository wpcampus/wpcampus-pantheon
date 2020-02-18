###
# Checks to ensure your environment variables are set.
#
# Is generally an admin script invoked from other scripts.
#
# Defines the following variables:
# - TERMINUS_BINARY
# - PANTHEON_EMAIL
# - SITE_NAME
# - SITE_PATH
###

# Pull in the functions we need.
source ./bash-functions.sh
source ./terminus-functions.sh

# Our Pantheon organization information.
ORG_LABEL="WPCampus"
ORG_NAME="wpcampus"

# Is the first argument received from the command.
SITE_NAME="wpcampus"

# Confirm we have a defined environment.
if [[ -z "${ENV_NAME}" ]]; then

  # Will be the second argument received from the command. Will always be dev, test, or live.
  ENV_NAME=$1

  if [[ -z "${ENV_NAME}" ]]; then
    printf "\nAn environment is required to run this script.\n\nCommand: %s [environment]\n\nExample: %s dev\n\n" "$0" "$0"
    exit 1
  fi
fi

SCRIPTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${SCRIPTDIR}"

# Check for the .env file.
if [ ! -f "${SCRIPTDIR}/.env" ]; then
  printf "\nCould not find the .env file. Copy the .env.sample to .env and customize the file.\n\nSee the README for more information.\n\n"
  exit 1
fi

source ".env"

# Check to see if Terminus is globally installed.
# If not, then we need the Terminus binary.
check_terminus=$(command -v terminus)
if [[ -z "${check_terminus}" && -z "${TERMINUS_BINARY}" ]]; then

  printf "\nTerminus is not installed globally so you must provide the path to your Terminus binary file in the .env file.\nSee the README for more information.\n\n"
  exit 1
else
  TERMINUS_BINARY="terminus"
fi

# Confirm we have Terminus authorization email.
if [[ -z "${PANTHEON_EMAIL}" ]]; then
  printf "\nYou must provide the email for your Pantheon account in the .env file.\nSee the README for more information.\n\n"
  exit 1
fi

SITE_PATH="${SITE_NAME}.${ENV_NAME}"

auth "${PANTHEON_EMAIL}"

display_header "Pinging the ${ORG_LABEL} ${ENV_NAME} environment"

wake_env "${SITE_PATH}"
