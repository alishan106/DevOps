import { LightningElement,track } from 'lwc';
import getRecentReports from '@salesforce/apex/TestExam.getRecentReports';

export default class TestExam extends LightningElement {

        @track options = [ ];

        @track value = '';
        
        connectedCallback() {
            
            getRecentReports()
                .then(data => {if(data){
                    const temp = { label: 'None', value: 'None' };
                    this.options = [ ...this.options, temp ];
                    for(var item of data) {
                        var acc = { label: item.Name, value: item.Id };
                        this.options = [ ...this.options, acc ];
                    }
                }
                    console.log('!@#'+JSON.stringify(this.reportOptions));
                })
                .catch(error => {
                    alert(JSON.stringify(error));
                });
        }
    
        handleRecentReportsChange(){
    
        }
    
    }