'use strict';

var path = require('path');
var timeout = 4000;
var dircompare = require('dir-compare');
var dcOptions = {
    compareSize: true,
    compareContent: true,
    skipSymlinks: true
};
var bddStdin = require('bdd-stdin');
var fs = require('fs');
var program = require('commander');
var chalk = require('chalk');
var pmock = require('pmock');
var backLog = console.log;
var generatedOutput;

require('../scripts').command(program);

exports.commularTest = {
    setUp: function (callback) {
        generatedOutput = [];
        this.cwd = pmock.cwd(__dirname + '/generated');
        console.log = function (message) {
            generatedOutput.push(message);
        };
        callback();
    },
    tearDown: function (callback) {
        program.commands = [];
        console.log = backLog;
        callback();
    },
    "Check that command have been added": function (test) {
        test.expect(1);
        test.equals(program.commands.length, 1, 'There is one command available.');
        process.on('beforeExit', function () {

            test.done();
        });
    },
    "Check that generate detects when not passing a valid template": function (test) {
        var expectedOutput = [
            chalk.green('Available templates:'),
            chalk.gray('Note: templates defined in your home folder overrides default templates.')
        ];
        test.expect(2);

        program.parse(['node', 'test', 'generate', 'test']);

        expectedOutput.forEach(function (output, index) {
            test.equals(generatedOutput[index], output, 'Our command tool has found a valid template');
        });
        test.done();
    },
    "Check that generates a widget properly": function (test) {
        var template_name = 'widget';
        var expectedOutput = [
            chalk.gray('Generating ' + template_name + ' on path: ' + process.cwd())
        ];

        test.expect(2);

        bddStdin('Widget_Test\n',
            'Description Widget\n', '1.0.0\n',
            'author@company.com\n', 'test\n', 'test\n',
            'N\n', 'N\n', 'a\n'
        );

        program.parse(['node', 'test', 'generate', template_name]);

        expectedOutput.forEach(function (output, index) {
            test.equals(generatedOutput[index], output, 'Our command tool has found a valid template');
        });

        setTimeout(function () {
            dircompare
                .compare(path.join(__dirname, 'expected', 'Widget_Test'), path.join(__dirname, 'generated', 'Widget_Test'), dcOptions)
                .then(function (res) {
                    test.equals(res.distinct, 0, 'Both widgets have the same content.');
                    test.done();
                })
                .catch(function (error) {
                    test.done();
                });
        }, timeout);
    },
    "Check that generates a template properly": function (test) {
        var template_name = 'template';
        var expectedOutput = [
            chalk.gray('Generating ' + template_name + ' on path: ' + process.cwd())
        ];

        test.expect(2);

        bddStdin('Test Template\n',
            'testTemplate\n', 'Personal\n',
            'P\n', 'N\n', 'N\n', 'a\n'
        );

        program.parse(['node', 'test', 'generate', template_name]);

        expectedOutput.forEach(function (output, index) {
            test.equals(generatedOutput[index], output, 'Our command tool has found a valid template');
        });

        setTimeout(function () {
            dircompare
                .compare(path.join(__dirname, 'expected', 'test-template'), path.join(__dirname, 'generated', 'test-template'), dcOptions)
                .then(function (res) {
                    test.equals(res.distinct, 0, 'Both templates have the same content.');
                    test.done();
                })
                .catch(function (error) {
                    test.done();
                });
        }, timeout);
    },
    // "Check that generates a project properly": function (test) { (Commented because it requires to use maven settings.xml)
    //     var template_name = 'project';
    //
    //     test.expect(1);
    //
    //     bddStdin('1.0.1\n',
    //         'com.mycompany.project\n', 'project\n',
    //         '1.0-SNAPSHOT\n', bddStdin.keys.down, '\n', '0.13.1\n'
    //     );
    //
    //     program.parse(['node', 'test', 'generate', template_name]);
    //
    //     setTimeout(function () {
    //         dircompare
    //             .compare(path.join(__dirname, 'expected', 'project'), path.join(__dirname, '..', 'project'), dcOptions)
    //             .then(function (res) {
    //                 test.equals(res.distinct, 0, 'Both projects have the same content.');
    //                 test.done();
    //             })
    //             .catch(function (error) {
    //                 test.done();
    //             });
    //     }, 8000);
    // },
    "Check that generates a lp-widget properly": function (test) {
        var template_name = 'lp-widget';

        test.expect(1);

        bddStdin('widget_launchpad_alike\n',
            'Widget Launchpad Architecture\n', '1.0.0\n',
            'author@company.com\n', 'Y\n', 'N\n', 'a\n'
        );

        program.parse(['node', 'test', 'generate', template_name]);

        setTimeout(function () {
            dircompare
                .compare(path.join(__dirname, 'expected', 'widget_launchpad_alike'), path.join(__dirname, 'generated', 'widget_launchpad_alike'), dcOptions)
                .then(function (res) {
                    test.equals(res.distinct, 0, 'Both launchpad widgets have the same content.');
                    test.done();
                })
                .catch(function (error) {
                    test.done();
                });
        }, timeout);
    },
    "Check that generates a lp-module properly": function (test) {
        var template_name = 'lp-module';

        test.expect(1);

        bddStdin('module-launchpad\n',
            'Module Launchpad Architecture\n', '1.0.0\n',
            'author@company.com\n', 'Y\n', 'N\n', 'a\n'
        );

        program.parse(['node', 'test', 'generate', template_name]);

        setTimeout(function () {
            dircompare
                .compare(path.join(__dirname, 'expected', 'module-launchpad'), path.join(__dirname, 'generated', 'module-launchpad'), dcOptions)
                .then(function (res) {
                    test.equals(res.distinct, 0, 'Both projects have the same content.');
                    test.done();
                })
                .catch(function (error) {
                    test.done();
                });
        }, timeout);
    },
    "Check that generates a container properly": function (test) {
        var template_name = 'container';

        test.expect(1);

        bddStdin('container-test\n',
            'ssr\n', 'container-test\n',
            'testTemplate\n',
            'layouts\n', 'layouts\n', 'Personal\n',
            'P\n'
        );

        program.parse(['node', 'test', 'generate', template_name]);

        setTimeout(function () {
            dircompare
                .compare(path.join(__dirname, 'expected', 'container-test'), path.join(__dirname, 'generated', 'container-test'), dcOptions)
                .then(function (res) {
                    test.equals(res.distinct, 0, 'Both containers have the same content.');
                    test.done();
                })
                .catch(function (error) {
                    test.done();
                });
        }, timeout);
    },
    "Check that generates an agnostic widget properly": function (test) {
        var template_name = 'agnosthic-widget';

        test.expect(1);

        bddStdin('test\n',
            'agnostic-widget\n', 'Agnostic Widget\n',
            '1.0.0\n', 'author@company.com\n',
            'test\n', 'test\n', 'N\n', 'N\n',
            'a\n'
        );

        program.parse(['node', 'test', 'generate', template_name]);

        setTimeout(function () {
            dircompare
                .compare(path.join(__dirname, 'expected', 'agnostic-widget'), path.join(__dirname, 'generated', 'agnostic-widget'), dcOptions)
                .then(function (res) {
                    test.equals(res.distinct, 0, 'Both agnostic widgets have the same content.');
                    test.done();
                })
                .catch(function (error) {
                    test.done();
                });
        }, timeout);
    }
};
