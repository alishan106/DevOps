({
    init: function (cmp, event, helper) {
        cmp.set('v.tabs', [{
            id: 'one',
            label: 'Account',
            count: 0,
            content: 'Number of times "Item One" selected: 0'
        }, {
            id: 'two',
            label: 'Contact',
            count: 0,
            content: 'Number of times "Item Two" selected: 0'
        }, {
            id: 'three',
            label: 'Case',
            count: 0,
            content: 'Number of times "Item Three" selected: 0'
        },{
            id: 'four',
            label: 'Opportunity',
            count: 0,
            content: 'Number of times "Item four" selected: 0'
        }
                          
       ]);
    },
    handleSelect: function (cmp, event, helper) {
        var nextConfigs = cmp.get('v.tabs').map(function (config) {
            if (config.id === event.getParam('id')) {
                config.count += 1;
                config.content = 'Number of times "' + config.label + '" selected: ' + config.count;
            }
            return config;
        });
        cmp.set('v.tabs', nextConfigs);
    }
});