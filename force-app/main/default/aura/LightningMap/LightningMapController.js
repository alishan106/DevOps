({
    doInit: function (cmp, event, helper) {
        cmp.set('v.mapMarkers', [
            {
                location: {
                    Street: 'M -15 Ana Sagar Link Road',
                    City: 'Ajmer',
                    State: 'Rajasthan'
                },

                title: 'iBirds Software Services Pvt. Ltd',
                description: 'Ajmer Rajasthan'
            }
        ]);
        cmp.set('v.zoomLevel', 10);
        
        cmp.set('v.mapMarkersMulti', [
            {
                location: {
                    City: 'Gorakhpur',
                    Country: 'India'
                },

                value: 'India',
                icon: 'custom:custom26',
                title: 'Gorakhpur'
            },
            {
                location: {
                    City: 'Delhi',
                    Country: 'India'
                },

                value: 'Delhi',
                icon: 'custom:custom96',
                title: 'Delhi'
            },
            {
                location: {
                    City: 'Mumbai',
                    Country: 'India'
                },

                value: 'Mumbai',
                title: 'Mumbai'
            },
            {
                location: {
                    City: 'Bhopal',
                    Country: 'India'
                },

                value: 'Bhopal',
                icon: 'custom:custom92',
                title: 'Bhopal'
            },
            {
                location: {
                    City: 'Goa',
                    Country: 'India'
                },

                value: 'Goa',
                icon: 'custom:custom61',
                title: 'Goa'
            },
            {
                location: {
                    City: 'Chennai',
                    Country: 'India'
                },

                value: 'Chennai',
                icon: 'custom:custom74',
                title: 'Chennai'
            },
            {
                location: {
                    City: 'Lucknow',
                    Country: 'India'
                },

                value: 'Lucknow',
                icon: 'custom:custom3',
                title: 'Lucknow'
            },
            {
                location: {
                    City: 'Jaipur',
                    Country: 'India'
                },

                value: 'Jaipur',
                icon: 'custom:custom54',
                title: 'Jaipur'
            },
            {
                location: {
                    City: 'Bengaluru',
                    Country: 'India'
                },

                value: 'Bengaluru',
                icon: 'custom:custom88',
                title: 'Bengaluru'
            },
            {
                location: {
                    City: 'Kashmir',
                    Country: 'India'
                },

                value: 'Kashmir',
                icon: 'custom:custom92',
                title: 'Kashmir'
            }
        ]);
        cmp.set('v.markersTitle', 'Incredible India');
    },
    handleMarkerSelect: function (cmp, event, helper) {
        var marker = event.getParam("selectedMarkerValue");
    }
});