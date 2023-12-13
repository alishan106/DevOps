import { LightningElement } from 'lwc';

export default class CountryStateCityExample extends LightningElement {

    data = [
        {
            "India" : {
                "Rajasthan" : {
                    "Ajmer" : "305001",
                    "Jaipur" : "305002",
                    "Kota" : "305003"
                },
                "mp" : {
                    "Bhopal" : "462036",
                    "Ujjain" : "462037",
                    "Ratlam" : "462038"
                },
                "UP" : {
                    "Lucknow" : "265207",
                    "Gorakhpur" : "273304",
                    "Allahabad" : "476325"
                } 
            },
            "Englend" : {
                "State1" : {
                    "City11" : "987654",
                    "City12" : "987653",
                    "City13" : "9876542"
                },
                "State2" : {
                    "City21" : "987654",
                    "City22" : "987655",
                    "City23" : "9876546"
                },
                "State3" : {
                    "City31" : "987648",
                    "City32" : "987649",
                    "City33" : "987650"
                }

            },
            "China" : {
                "Beijing" : {
                    "City11" : "997654",
                    "City12" : "887653",
                    "City13" : "776542"
                },
                "Sanghai" : {
                    "City21" : "667654",
                    "City22" : "557655",
                    "City23" : "4476546"
                },
                "Hong kong" : {
                    "City31" : "337648",
                    "City32" : "227649",
                    "City33" : "117650"
                }
        }
    }
    ];

    stateOptions;
    cities=[];
    country;
    state;
    selectedState;
    constructor(){
        super();
        console.log(this.data);
        console.log(this.data[0][this.country]);
    }

    get countryOptions(){
        var countryOptions = [];
        for(var country in this.data[0]){
            var obj = {};
            obj.label = country;
            obj.value = country;
            countryOptions.push(obj);
        }
        return countryOptions;
    }
    
    countryChange(event){
        if(event.target.name=="Country"){
        this.stateOptions = [];  
        country=event.target.value;       
        for(var stateValue in this.data[0][country]){   
            console.log('RRR'+stateValue);         
            var obj = {};
            obj.label = stateValue;
            obj.value = stateValue;            
            this.stateOptions.push(obj);            
        }
    }
    else if(event.target.name=="State"){
        this.cities=[]
        this.selectedState == event.target.value;
        for(var cityValue in this.date[0][country][this.selectedState]){
            var obj = {};
            obj.label = cityValue;
            obj.value = cityValue;            
            this.cities.push(obj);
        }
    }
    }

}