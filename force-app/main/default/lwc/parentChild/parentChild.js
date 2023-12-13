import { LightningElement, api, track} from 'lwc';
import iBirds_logo from '@salesforce/resourceUrl/iBirds_logo';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class parentChild extends LightningElement {

        @api  bikeId = undefined;
        defaultImage = iBirds_logo;
		@track bike = {};
        @api
        displayValue(details){
            this.bike.Name = details.Name;
            this.bike.Image_Link__c = details.Image_Link__c;
            this.bike.Price__c = details.Price__c;
            this.bike.Description__c = details.Description__c;
            this.bike.Quantity = details.Quantity;
            this.bike.Id = details.Id;
        }
        handleImgError(){
            this.bike.Image_Link__c = this.defaultImage;
        }
        handleClick(){
            if( parseInt(this.bike.Quantity) < 3){
                this.bike.Quantity = parseInt(this.bike.Quantity)+1;
                const customEvent = CustomEvent('simpleevent',{
                    detail : this.bike
                });
                this.dispatchEvent(customEvent);
            }else{
                 const toast = new ShowToastEvent({
                        title: 'Limit Exceed',
                        message: 'Can\'t add more than 3 of same bikes.',
                        variant: 'warning',
                    });
                    this.dispatchEvent(toast);
            }
        }


        
}