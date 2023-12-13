import { LightningElement } from 'lwc';

class AnalogClock extends LightningElement {

    connectedCallback() {
        setTimeout(() => {
            this.clock();
        }, 1000);
    }
    clock() {
        var dialLines = this.template.querySelectorAll('.diallines');  
          for (let i = 1; i < 61; i++) {
           // dialLines[i].style.transform = "rotate(" + 6 * i + "deg)";
         }
        console.log('efghi');
        var weekday = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ],
            d = new Date(),
            h = d.getHours(),
            m = d.getMinutes(),
            s = d.getSeconds(),
            date = d.getDate(),
            month = d.getMonth() + 1,
            year = d.getFullYear(),

            hDeg = h * 30 + m * (360 / 720),
            mDeg = m * 6 + s * (360 / 3600),
            sDeg = s * 6,
            hEl = this.template.querySelector('.hour-hand'),
            mEl = this.template.querySelector('.minute-hand'),
            sEl = this.template.querySelector('.second-hand'),
            dateEl = this.template.querySelector('.date'),
            dayEl = this.template.querySelector('.day');

        var day = weekday[d.getDay()];
        if (month < 9) {
            month = "0" + month;
        }
        hEl.style.transform = "rotate(" + hDeg + "deg)";
        mEl.style.transform = "rotate(" + mDeg + "deg)";
        sEl.style.transform = "rotate(" + sDeg + "deg)";
        dateEl.innerHTML = date + "/" + month + "/" + year;
        dayEl.innerHTML = day;
        setTimeout(() => {
            this.clock();
        }, 1000);
    }
}
export default AnalogClock;