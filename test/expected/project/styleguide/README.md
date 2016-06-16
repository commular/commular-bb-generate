# Project Documentation

Launchpad widgets, modules, and containers have been documented in a format compatible with the
Launchpad Styleguide, which is powered by [SourceJs](http://sourcejs.com/).

## Install the styleguide

```
mvn clean install
```

What does this do?

1. Download Launchpad Styleguide to **target/launchpad-styleguide**
2. Extract launchpad artifacts into **target/styleguide/user** (TODO: Run ukko to fetch styleguide deps).
3. Install node & npm (in styleguide).
4. Run (in styleguide) npm i && grunt.
5. Copy user overrides.
    - You can put files in the user directory, to override the styleguide defaults.
6. TODO: Windows fix, take pre-defined jsdom, copy to node_modules.

## Run the styleguide

On unix/osx:

```
sh run.sh
```

On windows:
```
run
```

View the styleguide on http://127.0.0.1:8080/

## Adding custom widgets

todo

## Developing in the Style Guide

todo
