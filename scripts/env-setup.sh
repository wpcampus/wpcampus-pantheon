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

# Is the first argument received from the command.
SITE_NAME=$1
shift

# Confirm we have a site name.
if [[ -z "${SITE_NAME}" ]]; then
  printf "\nA site name is required to run this script.\n\nCommand: %s <site_name>\n\nExample: %s heweb16\n\nThe site name is the name displayed at the top of the Pantheon Dashboard.\n\n" "$0" "$0"
  exit 1
fi

SCRIPTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${SCRIPTDIR}"

# Check for the .env file.
if [ ! -f "${SCRIPTDIR}/.env" ]; then
  printf "\nCould not find the .env file. Copy the .env.sample to .env and customize the file.\nSee the README for more information.\n\n"
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

# The SITE_NAME is the first argument received from the command.
SITE_PATH="${SITE_NAME}.${ENV_NAME}"
