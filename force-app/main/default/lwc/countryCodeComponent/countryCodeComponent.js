import { LightningElement, api, track } from 'lwc';
import intlTellinputjs from '@salesforce/resourceUrl/intlTellinputjs';
import utils from '@salesforce/resourceUrl/utils';
//import intlTellinputcss from '@salesforce/resourceUrl/intlTellinputcss';
import intlTelInput_min from '@salesforce/resourceUrl/intlTellinputcss';
import democss from '@salesforce/resourceUrl/democss';
import flags from '@salesforce/resourceUrl/flags';
import flagszoom from '@salesforce/resourceUrl/flagszoom';
import liveLocationJS from '@salesforce/resourceUrl/liveLocationJS';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';

export default class CountryCodeComponent extends LightningElement {
    @api CountryName = '';
    @track inputElem;
    @track iti;
    ini = '';

    @track tempArr =  [{name : ''}];

    onClickHandle(){
        let arr = {name : ''}
        this.tempArr.push(arr);
    }

      connectedCallback() {
          if(window.location.hostname.includes(".com")){
              this.ini = 'AU';
          }else{
            this.ini = 'NZ';
          }
        loadStyle(this, democss)
            .then(() => {

            });
        loadStyle(this, intlTelInput_min)
            .then(() => {

            });
        loadScript(this, utils)     
            .then(() => {

            });

            loadScript(this, liveLocationJS)
            .then(() => {
                fetch('https://stackoverflow.com/')
                .then(response => response.json())
                .then(data => console.log(data))

                $.get("https://ipinfo.io", function(response) {
                console.log('QQQQQQQQ',response.city, response.country);
                }, "jsonp");


                //let sTempURL = new URL('https://geolocation-db.com/json/');
                //console.log()
        //         $.ajax('https://geolocation-db.com/json/')
        //  .done (function(location) {
        //      console.log(JSON.stringify(location));
        //     $('#country').html(location.country_name);
        //     $('#state').html(location.state);
        //     $('#city').html(location.city);
        //     $('#latitude').html(location.latitude);
        //     $('#longitude').html(location.longitude);
        //     $('#ip').html(location.IPv4);
        //  });
        //         console.log('loaded');
            });

        loadScript(this, intlTellinputjs)
            .then(() => {
                this.inputElem = this.template.querySelector("[data-id=country]")
                console.log('selected element is -->', JSON.stringify(this.inputElem));
                console.log('selected this.ini -->', JSON.stringify(this.ini));
                window.intlTelInput(this.inputElem, {
                    utilsScript: utils,
                    initialCountry:this.ini,
                    onlyCountries: ['NZ', 'AU'],
                    nationalMode: true,
                    //preferredCountries: ['NZ', 'AU'],
                })
            })
    }
    onBlurHandle(){
        console.log('country Data 0');
        
        let inputFields = this.template.querySelector('.validate');
        inputFields.setCustomValidity("Country Code is required");
        inputFields.reportValidity();
        

    }
    onChangeHandle(){
        //console.log(event.target.value);
        let inputFields = this.template.querySelector('.validate');
        console.log('country Data 1');
        inputFields.setCustomValidity("");
        console.log('country Data 2');
        inputFields.reportValidity();

    }
    flagAndCounrtyCode() {
        var input = this.template.querySelector("[data-id=country]");
        var iti = window.intlTelInputGlobals.getInstance(input);
        var countryData = iti.getSelectedCountryData();
        console.log('country Data', countryData.dialCode);
        let phone = input.value;
        if (phone.charAt(0) === '0') {
            phone = phone.slice(1);
        }
        let temp = countryData.dialCode.length + 1;
        if (countryData.dialCode === phone.slice(1, temp)) {
            phone = phone.slice(temp);
            if (phone.charAt(0) === '0') {
                phone = phone.slice(1);
            }
        }
        phone = phone.replace(/[^\d]/g, '');
        console.log('country Data', countryData);
        console.log('## phone ##', phone);
        console.log('phone', countryData.dialCode + ' ' + phone);
        const phoneData = { code: countryData.dialCode, number: input.value, fullNumber: (countryData.dialCode + ' ' + phone) }
        const phoneChangeEvent = new CustomEvent('getphone', {
            detail: { phoneData },
        });
        this.dispatchEvent(phoneChangeEvent);
    }
}