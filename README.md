# HighEdWeb and Pantheon

Use this repo's scripts to communicate with and manage HighEdWeb websites hosted on Pantheon.

## Scripts

All of the scripts are located in the repo's `/scripts` directory.

To run a script, open the `/scripts` directory inside your computer's Terminal and type its command.

*These scripts have only been tested on Mac OS.*

### Script: Updating WordPress plugins

Use the following command to update the plugins for a specific site or a combination of sites:

```
bash plugins-update.sh [site name,site name,site name]
```

Replace `[site name]` with the [site name given by Pantheon](#highedweb-site-names).

Leave no spaces between the site names. For example:

```
bash plugins-update.sh hew16,hew17,hew18
```

#### Before you run the script

Make sure the Pantheon environment is set to SFTP mode.

#### After you run the script

This script will only update the plugin code on the Pantheon dev environment.

After you've tested the dev environment to ensure the updates didn't create issues, you will then have to commit the code updates to the site's TEST and PROD environments.

#### Committing code to TEST and PROD

You can commit the code changes inside the Pantheon Dashboard or through the Terminus CLI.

Run the following command to deploy code changes to a specific environment:

```
bash code-deploy.sh [site name] [environment] "[deploy note]"
```

Replace `[environment]` with the environment name: `dev`, `test`, or `live`.

Replace `[deploy note]` with a note describing the deploy. Be sure to keep the message in quotes.

### Script: Displaying list of WordPress plugins

Use the following command to display the list of plugins for a specific site or a combination of sites:

```
bash plugins-list.sh [site name,site name,site name]
```

Replace `[site name]` with the [site name given by Pantheon](#highedweb-site-names).

Leave no spaces between the site names. For example:

```
bash plugins-list.sh hew16,hew17,hew18
```

## Requirements

### 1) Access to the site's Pantheon Dashboard

If you're using one of these scripts to manage a website, you will need access to the site's Pantheon Dashboard.

*Contact the HighEdWeb Technical Committee for access.*

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

## HighEdWeb site names

The following are the Pantheon site names for each HighEdWeb site, which are passed as arguments to our scripts.

1. `highedweb` - [highedweb.org](https://www.highedweb.org/)
2. `hew16` - [2016.highedweb.org](https://2016.highedweb.org/)
3. `hew17` - [2017.highedweb.org](https://2017.highedweb.org/)
4. `hew18` - [2018.highedweb.org](https://2018.highedweb.org/)
5. `highedweb-2019-annual-conference` - [2019.highedweb.org](https://2019.highedweb.org/)
6. `highedweb-2020-annual-conference` - [2020.highedweb.org](https://2020.highedweb.org/)
7. `hewacademy` - [wpacademies.highedweb.org](https://wpacademies.highedweb.org/)
8. `hewlink` - [link.highedweb.org](https://link.highedweb.org/)
9. `hewregional` - [regionals.highedweb.org](https://regionals.highedweb.org/)
10. `highedweb-crm` - [membership.highedweb.org](https://membership.highedweb.org/)

## Files for Pantheon

Read the [Files for Pantheon README](/files_for_pantheon/README.md) for more information about files that must be placed on the Pantheon dev environment server.
