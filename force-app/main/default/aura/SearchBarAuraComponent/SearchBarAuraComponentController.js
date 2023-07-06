({
    doinit: function (component) {
        try {
            var action = component.get('c.retrieveCustomData');
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var allValues = response.getReturnValue();
                    console.log("allValues---------------- ", allValues);
                    component.set('v.custData', allValues);
                }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error Message: " + errors[0].message);
                        }
                    }
                    else {
                        console.log("Unknown Error");
                    }
                }
            });
            $A.enqueueAction(action);
        } catch (err) {
            console.log('_________catchBlock_________', err);
        }
    },

    searchKeyChange: function (component, event) {
        try {
            component.set('v.columns', [
                { label: 'ID', fieldName: 'Id' },
                { label: 'Name', fieldName: 'Name__c' },
                { label: 'IsTriggerFire', fieldName: 'isTriggerFire__c', editable: 'true' },
            ]);
            var selectedval = event.target.value;
            console.log('____________________Selected__________________', selectedval);

            var action = component.get('c.retrieveSelectedCustomDataName');
            action.setParams({
                "selectedDropValues": selectedval
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var allValues = response.getReturnValue();
                    console.log("allValues---------------- ", allValues);
                    component.set('v.objectDetails', allValues);
                    console.log('______component.setobjectDetails_____', component.get('v.objectDetails'));
                }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error Message: " + errors[0].message);
                        }
                    }
                    else {
                        console.log("Unknown Error");
                    }
                }
            });
            $A.enqueueAction(action);
        } catch (err) {
            console.log('____________searchCatchBlock____________', JSON.stringify(err));
        }
    },

    handleSave: function (Component, event) {
        console.log('_____________handleSave________________');
        var draftValues = event.getParam('draftValues');
        console.log('______________editValue_______________', draftValues);
        console.log('______________editValue2_______________', JSON.stringify(draftValues[0].isTriggerFire__c));
        var draft = JSON.stringify(draftValues[0].isTriggerFire__c);
        var rowId = JSON.stringify(draftValues[0].id);
        console.log('_______________draft_________________', draft);
        console.log('_______________rowId_________________', rowId);
        
        var action = Component.get('c.updateCustomDataValue');
        // console.log('___________Component.get____________', Component.get('c.updateCustomDataValue'));
        action.setParams({
            "acc": draft,
            "row": rowId    
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var allValues = response.getReturnValue();
                console.log('_______________allValues__________________', allValues);
                Component.set('v.draftValues', allValues);
                console.log('______Component.setobjectDetails_____', Component.get('v.draftValues'));
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error Message: " + errors[0].message);
                    }
                }
                else {
                    console.log("Unknown Error");
                }
            }
            $A.get('e.force:refreshView').fire();
        });
        $A.enqueueAction(action);
    },
})