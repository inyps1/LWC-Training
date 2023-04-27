import { LightningElement, api } from 'lwc';

export default class CalculatorComp extends LightningElement {

    //Define properties- private, public, global
    @api firstNumber;
    @api secondNumber;
    result;

    //1.constructor
    constructor() {
        super();
        console.log('constructor....', this.firstNumber + this.secondNumber);
    }

    //2. public properties will be assigned values

    //3.
    connectedCallback() {
        //do event registration
         console.log('connected callback....', this.firstNumber + this.secondNumber);
    }

    //4. render //LWC specific to deal with html
    //5. render callback//load third part css/javascript//apply css programatically
    renderedCallback() {
        console.log('the result is', this.result);
        this.result = 100;
        console.log('the result is from renderedcallback', this.result);
    }

    //6. on component remove from dom, unregister events here 
    disconnectedCallback() {

    }

    //7. LWC specific 
    errorCallback() {

    }

    //define event handlers
    handleFirstNumber = (event) => {
        this.firstNumber = parseInt(event.target.value); 
    }

    handleSecondNumber = (event) => {
        this.secondNumber = parseInt(event.target.value);
    }

    //define action methods
    add = () => {
        this.result = this.firstNumber + this.secondNumber;
    }

    sub = () => {
        this.result = this.firstNumber - this.secondNumber;
    }

    mult = () => {
        this.result = this.firstNumber * this.secondNumber;
    }

    div = () => {
        this.result = this.firstNumber / this.secondNumber;
    }

}