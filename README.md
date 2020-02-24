# WPCampus and Pantheon

Use this repo's scripts to communicate with and manage the WPCampus website hosted on Pantheon.

## Scripts

All of the scripts are located in the repo's `/scripts` directory.

To run a script, open the `/scripts` directory inside your computer's Terminal and type its command.

*These scripts have only been tested on Mac OS.*

### Script: Displaying list of WordPress plugins

Use the following command to display the list of plugins on our site:

```
bash plugins-list.sh
```

### Script: Updating WordPress plugins

Use the following command to update the plugins on our site:

```
bash plugins-update.sh
```

#### Before you run the script

Make sure the Pantheon environment is set to SFTP mode.

#### After you run the script

This script will only update the plugin code on the Pantheon dev environment.

After you've tested the dev environment to ensure the updates did not create issues, you will then have to deploy the code to the site's TEST and PROD environments.

### Script: Clearing Pantheon cache

Use the following command to clear the caches for a specific Pantheon environment:

```
bash clear-cache.sh [dev|test|live]
```

### Script: Creating a backup

Use the following command to create a backup for a specific Pantheon environment:

```
bash backup-create.sh [dev|test|live] [all|code|files|database|db]
```

The first argument defines the environment. The second argument defines which elements will be backed up.

### Script: Deploying "hotfix" to production environment.

Use the following command to deploy code all the way to production for a "hotfix":

```
bash deploy-hotfix.sh "[commit message]"
```

### Script: Setting the connection mode to git or sftp

Use the following command to set the connection mode to git or sftp. It can only be done on the dev environment.

```
bash connection.sh [git|sftp]
```

### Script: Deploying code to TEST or PROD environment

You can only commit code to the dev environment. Once tested on dev, you then deploy the code to the TEST and PROD environments. 

You can deploy inside the Pantheon Dashboard or through the Terminus CLI.

Run the following command to deploy:

```
bash code-deploy.sh [test|live] "[deploy note]"
```

Replace `[deploy note]` with a note describing the deploy. Be sure to keep the message in quotes.

## Requirements

### 1) Access to the site's Pantheon Dashboard

If you're using one of these scripts to manage a website, you will need access to the site's Pantheon Dashboard.

*Contact the WPCampus Technical Committee for access.*

### 2) Terminus must be installed on your machine

Terminus is Pantheon's CLI (Command Line Interface). It's how our scripts interact with our Pantheon environments.

[Visit the Terminus documentation](https://pantheon.io/docs/terminus) to learn more about the product.

* [How to install Terminus](https://pantheon.io/docs/terminus/install)

### 3) Create your .env file

Our scripts require information unique to the user running the script.

To setup: copy the `.env.sample` file included in the repo, rename to `.env`, and populate the following information:

* `PANTHEON_EMAIL`
    * The email address used for your Pantheon account. This is required for Terminus authentication.
* `TERMINUS_BINARY`
    * This is only required if the Terminus binary you installed is not available globally on your machine and therefore not accessible by our scripts.
    * To test: run `terminus` inside your Terminal.
        * **If lots of Terminus information printed:** you do not need to define `TERMINUS_BINARY`.
        * **If the `terminus` command didnt work:** Set `TERMINUS_BINARY` equal to the directory path of your Terminus bin file. The `env.sample` file includes an example.

## Files for Pantheon

Read the [Files for Pantheon README](/files_for_pantheon/README.md) for more information about files that must be placed on the Pantheon dev environment server.
