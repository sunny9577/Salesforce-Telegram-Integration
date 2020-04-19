({
    sendMessage : function(component) {
        let messageBody = component.find('messageBody').get("v.value");;
        let action = component.get('c.sendMessage');
        action.setParams({
            contactId : component.get('v.recordId'),
            messageBody : messageBody,
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            var toastEvent = $A.get("e.force:showToast");
            if (state === "SUCCESS") {
                // Process server success response
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Message sent successfully.",
                    "type" : "success"
                });
            }
            else {
                // Pass the error message if any
                let errors = response.getError();
                console.log(errors);
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    // Process error returned by server
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": errors[0].message,
                        "type" : "error"
                    });
                }
            }
            toastEvent.fire();
        });
        $A.enqueueAction(action);
    }
})