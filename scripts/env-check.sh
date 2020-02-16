###
# Checks to ensure your environment variables are set.
#
# Is generally an admin script invoked from other scripts.
###

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
