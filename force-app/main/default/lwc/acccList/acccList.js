import { LightningElement ,track,wire} from 'lwc';
import getAccounts from '@salesforce/apex/ThirdAssignment.getAccounts';
export default class AcccList extends LightningElement {
 @track data =[]
 @track data1 =[]
    @wire (getAccounts) wiredAccounts({data,error}){
        if (data) {
            this.data = JSON.parse(JSON.stringify(data));
            this.data2 = JSON.parse(JSON.stringify(data));
            let combobox=[];
            data.forEach(element => {
                combobox.push({label:element.Name, value:element.Id});
              });
            this.data1 =combobox;
            console.log('combobox',this.data1);
            console.log('combobox',combobox);
        console.log('data====*****',data); 
        } else if (error) {
        console.log('error',error);
        }
   }
   handleRemoveRecord(event){
       console.log(JSON.stringify(event.target.value));
       console.log('\''+event.target.value+'\'');
       this.data=this.data2.filter(x => x.Id === event.target.value);      
       console.log('data###',this.data)
   }
}