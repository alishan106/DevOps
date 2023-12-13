import { LightningElement,track } from 'lwc';
export default class DynamicTableExample extends LightningElement {
    
@track tbl = [{
    "DateRange":"Range1",
    "Income":"Income1"
},
{
    "DateRange":"Range2",
    "Income":"Income2"
},
{
    "DateRange":"Range3",
    "Income":"Income3"
},
{
    "DateRange":"Range4",
    "Income":"Income4"
}];
}