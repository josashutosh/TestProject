//only numbers
//onkeypress = "return isNumberKey(event)"
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
}
//decimal number (200.36)
//onkeypress = "return restrict(this.value, event)"
function restrict(val, e) {
    var keyChar;
    if (window.event)
        keyChar = String.fromCharCode(window.event.keyCode);
    else if (e)
        keyChar = String.fromCharCode(e.which);
    else
        return true;
    var number = parseFloat(val + keyChar);
    if (number != val + keyChar)
        return false;
    else
        return true;
}

//office Number
//onkeypress = "return isNumberspecialcharKey(event)"
 function isNumberspecialcharKey(event) {
            var regex = new RegExp("^[0-9?=.*!@#$%^&*]+$");
            var key = String.fromCharCode(event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                event.preventDefault();
                return false;
            }
        }  


