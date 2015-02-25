var clientData = {
    id: 094545,
    fullName: "Not Set",
    // setUserName is a method on the clientData object
    setUserName: function (firstName, lastName)  {
        // this refers to the fullName property in this object
      this.fullName = firstName + " " + lastName;
    }
}

function getUserInput(firstName, lastName, callback, callbackObj)  {
    // Do other stuff to validate firstName/lastName here
    // Now save the namej
    callback.apply(callbackObj, [firstName, lastName]);
}

getUserInput("Wang", "Zhijun", clientData.setUserName, clientData);
console.log(clientData.fullName);

