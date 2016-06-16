// Add your Javascript code.
test = test || {};
test.widgets = test.widgets || {};
test.widgets['agnostic-widget'] = {
    init: function (widgetInstance) {
        console.log(widgetInstance.name);
    }
};