# commular-bb-generate

[![NPM Version](http://img.shields.io/npm/v/commular-bb-generate.svg?style=flat)](https://npmjs.org/package/commular-bb-generate)
[![Build Status](http://img.shields.io/travis/tcorral/commular-bb-generate.svg?style=flat)](https://travis-ci.org/tcorral/commular-bb-generate)
[![Build status](https://ci.appveyor.com/api/projects/status/3j6wb679ipd1maqp?svg=true)](https://ci.appveyor.com/project/tcorral/commular-bb-generate)

A [commular](https://github.com/tcorral/commular) module to Generate Backbase Components.

### Generate

Scaffold new widgets, containers and other Backbase CXP components.

The tool generates the starting template for the chosen item in the directory where you run the command.

```
[cli_name] generate widget
```

```
[cli_name] generate container
```

```
[cli_name] generate project
```

```
[cli_name] generate template
```

Read more about generate API [here](/docs/generate.md).


To get more information I recommend to read the use cases in tests.

## Tests

To run the tests:

```bash
npm install
npm test
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
4. Commit your changes: `git commit -am 'Add some feature'`
5. Check that it still works: `npm test`
6. Push to the branch: `git push origin my-new-feature`
7. Submit a pull request :D

## History

0.1.0 - Initial version.

## License

The MIT License (MIT)

Copyright (c) 2016 Tomás Corral

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
