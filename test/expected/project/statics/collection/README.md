# Static Collection

The static collection is a flat list of all static assets to be imported into the portal. This
includes:

 - containers
 - features (shared dependencies: angular, themes)
 - pages
 - templates
 - widgets


The main dependencies for a *Launchpad* project are:

 - requirejs
 - config (requirejs config, etc)
 - [collection-universal](https://bitbucket.org/backbase/lpc-collection-universal)
 - [collection-retail](https://bitbucket.org/backbase/lpc-collection-retail) (if
   you selected the retail edition).
 - [theme-default](https://bitbucket.org/backbase/lpm-theme-default)

You can see the [bower.json](bower.json) to see this, and set the versions to depend on.


The collection is built with `bower`. To build the collection you can run:

```
mvn clean package
```

This is essentially a wrapper around `bower install`.

This section contains the static only artifacts that will be use to build the portal FE 
(inc pages, containers, widgets, themes, css and js etc).


To import the components, run:

```
./npm run import-collection
```

or on Windows:

```
npm.cmd run import-collection
```

> Running `./npm [OPTIONS]` inside `statics/collection` directory will run locally installed version of npm.  
> Running `npm [OPTIONS]` will run globally installed version of npm.

This uses the [`bb-cli`](https://github.com/Backbase/bb-cli/tree/nightly) (nightly)

You can see the [package.json](package.json) to see how it runs this script.

The import script will:

 - Load the bower dependency list.
 - Order the bower dependency list, so (for example) templates are imported before pages/containers.
 - Zip each bower dependency.
    - If no model.xml exists then one will be generated automatically, and the component will be
      imported as a "feature".
    - The version of each dependency will be taken from bower, and added to the model.xml as
      a property.
 - Upload the zip using portal's REST API.

See the [`bb-cli`](https://github.com/Backbase/bb-cli/tree/nightly) (nightly) for more documentation.


Imported components will be moved to the contextRoot specified in the `backbase.properties` files.
By default this is `statics/dist/itemRoot`. There you will find the imported components, imported into
`statics/dist/itemRoot/{item type}/[BBHOST]/{item name}`.

You can reference your components from the web at `$(contextRoot)/{item type}/[BBHOST]/{item name}`/


Install:
  - [`bblp`](https://www.npmjs.com/package/bb-lp-cli) and the
  - [`bb-cli`](https://www.npmjs.com/package/bb-cli)


 1. Clone the component repository.
   - It doesn't matter where you clone it to. You can clone it anywhere to your computer.
 1. Install the bower components.
   - `cd <component>; bower install`
 1. Run the build.
   - `cd <component>; bblp build`
 1. In a separate window, run the importer.
   - `cd <component>; bb import-item -w`

Now any changes you make will rebuild the `/dist` and be automatically imported into your running
portal.



If you have a custom component (widget/container/etc) in a separate *git* respository, simply add
it to the bower.json as a dependency. You can even add entire collections of components following
the example of the `collection-universal`.



TL;DR: To develop a new widget/container/etc simply add it to your statics and include it in the
collection's bower.json.


In this example we'll override the login widget. But this process should work for any custom 
component.

---

 > **Note:** It's *not* recommend to override a Launchpad Component. It should only be done if you
 intend to have your changes merged back into the Launchpad Codebase, and you will then remove 
 the override.

---

 1. In the collection:
    - `cd statics/collection`
    - `mkdir widgets`
 1. Clone the component repository into your project.
   - `git clone git@bitbucket.org:backbase/lpw-widget-login-multifactor.git`
     widgets/widget-login-multifactor`
   - `cd .../widgets/widget-login-multifactor`
 1. Install the bower components.
   - `bower install`
 1. Run the build:
   - `bblp build`
 1. In a separate terminal, run the importer.
   - `cd widgets/widget-login-multifactor`
   - `bb import-item -w`
 1. To include the widget in the collection's import, add it to the bower.json:

```json
    ...
    "dependencies": {
      ...
      "widget-login-multifactor": "./widgets/widget-login-multifactor"
      ...
    }
    ...
    "resolutions": {
      "widget-login-multifactor": "*"
    }
```

Now when you build and import the collection your widget will be included in the catalog.


The collection will have the `theme-default` installed by default (see [bower.json](bower.json)).

To create a custom theme, clone the
[theme-default](https://bitbucket.org/backbase/lpm-theme-default) into your
project into the `themes` directory. See the *Custom Components* section for details on how to install it into this project.

The [theme-default](https://bitbucket.org/backbase/lpm-theme-default) has more
documentation on how to build your theme.
