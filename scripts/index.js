var fs = require('fs');
var path = require('path');
var chalk = require('chalk');
var _ = require('lodash');
var Table = require('cli-table');
var map = require('map-stream');
var gulp = require('gulp');
var osenv = require('osenv');

var bbscaff = require('./lib/bbscaff');

var homeDir = osenv.home();
var templatesDir = [
    path.join(homeDir, '.bbscaff'),
    path.join(__dirname, '..', 'templates')
];

function listTemplates(){
    console.log(chalk.green('Available templates:'));
    console.log(chalk.gray('Note: templates defined in your home folder overrides default templates.'));

    var foundTemplates = [];
    var table = new Table({
        head: ['Template name', 'Path']
    });

    gulp.src(templatesDir.map(function(tmpl){
        return path.join(tmpl, '**', 'bbscaff.js');
    })).pipe(map(function(file, cb){
            var templatePath = path.dirname(file.path);
            var templateName = _.last(templatePath.split(path.sep));

            if (_.indexOf(foundTemplates, templateName) === -1) {
                table.push([templateName, chalk.gray(templatePath)]);
            }

            foundTemplates.push(templateName);
            cb();
        }))
        .on('end', function(){
            console.log(table.toString());
        });
}

exports.command = function (program) {
    program
        .command('generate [template_name]')
        .on('--help', function () {
            var title = chalk.bold;
            var programName = program.name();
            var commandName = this.name;
            var r = '\n  ' + title('Usage') + ': ' +  programName + ' ' + commandName + ' <template-name>';
            r += '\n\t Scaffold widgets and containers.\n';
            r += '\n  ' + title('Examples') + ':\n';
            r += '      '+ programName + ' ' + commandName + ' widget\n';
            r += '      '+ programName + ' ' + commandName + ' container';
            return r;
        })
        .action(function (template_name) {
            if (!template_name) {
                return listTemplates();
            }

            var tmpl_path = _.find(templatesDir, function(tmpl_path){
                return fs.existsSync(path.join(tmpl_path, template_name, 'bbscaff.js'));
            });
            
            if (tmpl_path){
                console.log(chalk.gray('Generating ' + template_name + ' on path: ' + process.cwd()));
                var templateModule = require(path.join(tmpl_path, template_name, 'bbscaff'));
                templateModule(_.extend({}, bbscaff, {
                    template_dir: path.join(tmpl_path, template_name, 'template')
                }));
            } else {
                listTemplates();
            }
        });
};