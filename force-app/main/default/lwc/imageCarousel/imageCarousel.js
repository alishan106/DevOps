import { LightningElement, track } from 'lwc';

export default class ImageCarousel extends LightningElement {

    @track tempImgList = [];
    @track imgList = [{ label: 'img1', value: 'https://m.media-amazon.com/images/I/51nCZCTu6XS._SL1500_.jpg',active:false },
    { label: 'img2', value: 'https://m.media-amazon.com/images/I/81S-KX8ojWS._SL1500_.jpg',active:false },
    { label: 'img3', value: 'https://m.media-amazon.com/images/I/51mi7SXBDmS._SL1500_.jpg',active:false },
    { label: 'img4', value: 'https://m.media-amazon.com/images/I/61JXUp06y8S._SL1500_.jpg',active:false },
    { label: 'img5', value: 'https://m.media-amazon.com/images/I/519uMzMXJVL._SX569_.jpg',active:false},
    { label: 'img6', value: 'https://m.media-amazon.com/images/I/518lLOGxjfL._SX569_.jpg',active:false },
    { label: 'img7', value: 'https://m.media-amazon.com/images/I/61AzOUlJOHL._SX569_.jpg',active:false },
    { label: 'img8', value: 'https://m.media-amazon.com/images/I/51wi0sZVqyL._SX569_.jpg',active:false }];
    img = this.imgList[0].value;
    nextButtonValue = false;
    previousButtonValue = true;
    startVar = 0;
    endVar = 4;

    connectedCallback() {
        
        setTimeout(() => {
            for (let i = 0; i < 4; i++) {
                this.tempImgList.push(this.imgList[i]);
            }
            console.log(this.tempImgList);
        }, 500);        
        this.chevronHandle();
    }

    handleImageClick(event) {

        for (let i = 0; i < this.imgList.length; i++) {
            if(event.target.dataset.id !== i){
            this.imgList[i].active = false;
            if(i < 4){                
                this.template.querySelector('[data-id="'+i+'"]').className='noneBorder';
                this.tempImgList[i].active = false; 
            }
            }
        }
        this.tempImgList[event.target.dataset.id].active = true;
        console.log(JSON.stringify(this.tempImgList));
        this.img = this.tempImgList[event.target.dataset.id].value;
        this.template.querySelector('[data-id="'+event.target.dataset.id+'"]').className='boxBorder';
        this.oldSelectedIndex = event.target.dataset.id;
    }

    previousClick() {         
        if (this.startVar > 0) { 
            this.startVar = this.startVar - 1;
            this.endVar = this.endVar - 1;
            if (this.startVar >= 0) {
                this.tempImgList = [];
                for (let i = this.startVar; i < this.endVar; i++) {
                    this.tempImgList.push(this.imgList[i]);                
                }
            }
        } 
        this.chevronHandle();
        try {
            this.template.querySelector('.true').className='boxBorder';
        } catch (error) {
            console.log(error);
        }
    }

    nextClick() {        
        if (this.endVar < this.imgList.length) {            
            this.startVar = this.startVar + 1;
            this.endVar = this.endVar + 1;
            if (this.endVar <= this.imgList.length) {
                this.tempImgList = [];
                for (let i = this.startVar; i < this.endVar; i++) {
                    this.tempImgList.push(this.imgList[i]);
                }
            }
        }        
        this.chevronHandle();        
        try {
            this.template.querySelector('.true').className='boxBorder';
        } catch (error) {
            //console.log(error);
        }
    }
    
    chevronHandle(){
        this.nextButtonValue = this.endVar >= this.imgList.length;
        this.previousButtonValue = this.startVar <= 0;
    }
}