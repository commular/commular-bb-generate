# Project README

Make sure to follow the next steps in order to setup this project locally.

## Pre-Requisites

 * Setup your SSH key in bitbucket or stash (for building the static collection).

----

## Building the project

### Initial/cleanup build, recreating the database

```
mvn clean install \
    -Pclean-database
```

Without using options process will download Node/NPM locally and Launchpad components from Backbase artifactory.

#### Options

* To download the node_modules from npm using `npm install`, instead of using the pre-packed node_modules from artifactory.

```
-Dnpm-install
```

----

## Running the webapps.

### Running all 4 webapps at once:

 - On Linux/OSX: `sh run.sh`
 - On Windows: `run.bat`

* To run webapps in the background add `-b` flag
* To run with Launchpad demo services demo services add `-d` flag

### Running webapps individually

Web applications are inside `webapps` directory

* portalserver
* contentservices
* orchestrator
* solr

Each webapp has `run` script.
To run portal with demo services use `run_with_demo` script.

----

## Importing

Change your working directory to `statics/collection` from the root of your project.

```
cd statics/collection
```
> To run Maven installed versions of `node`, `npm`, `bower` and `bb`:
> * on Linux/OSX add `./` prefix to command name
> * on Windows add `.cmd` suffix to command name
>
> Otherwise, system will run globally installed commands that can be outdated.

### Import the CXP-Manager and Universal Catalog


Open `http://localhost:7777/portalserver/import` in your browser and clicking on Import button.

### Import the launchpad collection

On Linux/OSX:

```
./npm run import-collection
```

On Windows:

```
npm.cmd run import-collection
```

### Import Demo Portal

> Requires Launchpad Retail collection to be iinstalled.

On Linux/OSX:

```
./npm run import-retail-portal
```

On Windows:

```
npm.cmd run import-retail-portal
```


----

## Developing

### Static Collections

See the [collection readme](statics/collection).

### Theming

A default theme is provided in the collection. See the 
([theme-default](https://bitbucket.org/backbase/lpm-theme-default)) README for
details.

----

## Module descriptions
Here is list if all Maven modules together with its description:

* **configuration** contains all project configurations.
* **dist** produces distribution of all modules.
* **services** is parent module for all Integration services.
* **statics** is parent module for all web static assets packaged as Backbase bundles.
* **webapps/portalserver** is backbase portal module.
* **webapps/contentservices** is customized `contentservices` module able to run as standalone service.
* **webapps/orchestrator** is customized `orchestrator` module able to run as standalone service.
* **webapps/solr** is providing search capabilities for portalserver.
