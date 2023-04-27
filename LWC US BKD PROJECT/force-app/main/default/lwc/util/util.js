import {ShowToastEvent} from 'lightning/platformShowToastEvent';

const _showToast = (thisArg, title, message, variant) => {
    const eventRef = new ShowToastEvent({title, message, variant});
    thisArg.dispatchEvent(eventRef);
}

export {
    _showToast
}