import { LightningElement } from 'lwc';

export default class LoginUserInCommunityPage extends LightningElement {

    loginName;
    passName;
    clicked;

    loginChange(event){
        this.loginName = event.target.value;
        console.log('____________loginChange______________', this.loginName);
    }
    passChange(event){
        this.passName = event.target.value;
        console.log('____________passChange______________', this.passName);
    }
    handleClick(event){
        this.clicked = event.target.value;
        console.log('___________clicked___________', this.clicked);
    }
}