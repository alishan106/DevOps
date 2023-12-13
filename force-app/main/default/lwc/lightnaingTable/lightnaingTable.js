import { LightningElement,track } from 'lwc';
export default class LightnaingTable extends LightningElement {
    totalAddBacks;
    totalAddBackswithDoller = '$ 0.00';
    handleChange1
    handleChange(event){
        let inp=this.template.querySelectorAll(".input");
       let actualAmount=0.00; 
        inp.forEach(function(element){
            console.log("Element value",parseFloat(element.value));
            if(parseFloat(element.value) > 0){
            actualAmount+=parseFloat(element.value)
            }
        });
        this.totalAddBacks = parseFloat(actualAmount);
        console.log("this.actualAmount1",this.totalAddBacks)
        this.totalAddBackswithDoller = '$ ' + this.totalAddBacks;  
    }

    // handleCalculated(event){
    //     let percente = this.template.querySelector(".percente").value;
    //     let actual = this.template.querySelector(".actual").value;        
    //     this.handleChange1 = parseInt((actual*percente)/100);
    //     console.log('!!!!!',actual*percente);
    // }
}