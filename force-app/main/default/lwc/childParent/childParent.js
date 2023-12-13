import { LightningElement, track } from 'lwc';

export default class childParent extends LightningElement {
    selectedbike ;
	@track bikes = [
        {
           "Name":"YAMAHA FZ S",
           "Price__c":105000,
           "Description__c":"149CC 45KMPL 137KG",
           "Image_Link__c":"https://media.zigcdn.com/media/model/2021/Feb/yamaha-fzsfi-new-right-side-view_360x240.jpg",
           "Id":"a025g000002uvwuAAA",
           "Quantity":"0"
        },
        {
           "Name":"YAMAHA FZ25",
           "Price__c":255000,
           "Description__c":"249CC 36.6KMPL 153KG",
           "Image_Link__c":"https://imgd.aeplcdn.com/393x221/bw/models/yamaha-fz25-standard20200727170517.jpg?q=85",
           "Id":"a025g000002uvwvAAA",
           "Quantity":"0"
        },
        {
           "Name":"KTM 250 DUKE",
           "Price__c":224000,
           "Description__c":"249CC 30KMPL 169KG",
           "Image_Link__c":"https://imgd.aeplcdn.com/393x221/bw/models/ktm-250-duke-bs-vi20200805125938.jpg?q=85",
           "Id":"a025g000002uvwwAAA",
           "Quantity":"0"
        },
        {
         "Name":"HUSQVARNA SVARTPILEN 250",
         "Price__c":195000,
         "Description__c":"248.5CC 30KMPL 166KG",
         "Image_Link__c":"https://imgd.aeplcdn.com/393x221/bw/models/husqvarna-svartpilen-250-standard20200225140010.jpg?q=85",
         "Id":"a025g000002uvioAAA",
         "Quantity":"0"
      },
        {
           "Name":"YAMAHA MT 15",
           "Price__c":141000,
           "Description__c":"155CC 45KMPL 138KG",
           "Image_Link__c":"https://imgd.aeplcdn.com/393x221/bw/models/yamaha-mt-15-bs-vi20200204191522.jpg?q=85",
           "Id":"a025g000002uvwpAAA",
           "Quantity":"0"
        }
     ]; 
     handleChange(event){
         let checkboxClass = '.'+event.target.value;
         const checkbox = this.template.querySelector(checkboxClass);
        if(checkbox.checked === true){
            Array.from(this.template.querySelectorAll('lightning-input'))
            .forEach(element => {
                element.checked = false;
            });
           checkbox.checked = true;
           this.selectedbike = event.target.value;
           let details = this.bikes.find(data => data.Id === this.selectedbike);
           this.template.querySelector("c-parent-Child").displayValue(details);
        }else{
            this.selectedbike = null;
        }
     }
    
     handleSimpleEvent(event){
        let findId = event.detail.Id;
        var index = 0;
        for(var data in this.bikes){
            if(this.bikes[data].Id === findId){
                break;
           }
           index += 1;
        }
        this.bikes[index].Quantity = event.detail.Quantity;
        
    }    

}