import { LightningElement } from 'lwc';

export default class CountAlphabetInLWC extends LightningElement {
    textAreaFieldValue;
    textErase = '';
    countofletters = 0;
    countofspaces = 0;
    countofwords = 0;
    checkforwordcount = true;
    checkforwordcount2 = false;
    splittedarray = [];
    splitarrwithspace = [];


    handleOnChange(event) {
        this.textAreaFieldValue = event.target.value;
        
        if (this.textErase.length < this.textAreaFieldValue.length) {
            if (/^[a-z0-9A-Z~!@#$%^&-_=*]+$/.test(this.textAreaFieldValue.slice(this.textAreaFieldValue.length - 1, this.textAreaFieldValue.length))) {
                this.countofletters++;

                if (this.checkforwordcount == true) {
                    this.countofwords++;
                    this.checkforwordcount = false;
                }
            }
            else {
                this.checkforwordcount = true;
                this.countofspaces++;
            }
        }
        else {
            if (( /^[a-z0-9A-Z~!@#$%^&-_=*]+$/.test(this.textErase.slice(this.textErase.length - 1, this.textErase.length)))) {
                this.countofletters--;

                if (!this.checkforwordcount2 && !(/^[a-z0-9A-Z~!@#$%^&-_=*]+$/.test(this.textAreaFieldValue.slice(this.textAreaFieldValue.length - 1, this.textAreaFieldValue.length)))) {
                    this.countofwords--;
                    this.checkforwordcount2 = true;
                }
            }
            else {
                this.checkforwordcount2 = false;
                this.countofspaces--;
            }
        }
        this.textErase = this.textAreaFieldValue;
    }

    handleCountChange(event)
    {
        var s = event.target.value;
        this.splittedarray = s.split("");
        this.splitarrwithspace = s.split(" ");

        let letters=[], spaces=[], words=[];
        // console.log('the split array -> ',JSON.stringify(this.splittedarray));
        // console.log('the split array with space -> ',JSON.stringify(this.splitarrwithspace));

        for (let i = 0; i < this.splittedarray.length; i++) 
        {
            if (this.splittedarray[i] == " ")
            {
                spaces.push(this.splittedarray[i]);
            } else 
            {
               letters.push(this.splittedarray[i]); 
            }  
        }
        for (let j = 0; j < this.splitarrwithspace.length; j++) {
            if(this.splitarrwithspace[j])
            {
                words.push(this.splitarrwithspace[j]);
            }
            
        }
        // console.log(' l = ',JSON.stringify(l));
        // console.log(' sp = ',JSON.stringify(sp));
        // console.log(' splitwitharr = ',JSON.stringify(w));
        
        this.countofletters = letters.length;
        this.countofspaces = spaces.length;
        this.countofwords = words.length;
    }
}