({
    doInit: function (component) {
        try {
            var allObjects = $A.get("$Label.c.StandardObject").split(',');
            console.log('__________allObjects____________', JSON.stringify(allObjects));
            component.set('v.setOfObjects', allObjects);

            component.set('v.columns', [
                { label: 'BatchID', fieldName: 'BatchId__c' },
                { label: 'ObjectName', fieldName: 'ObjectName__c' },
                { label: 'JobCount', fieldName: 'JobCount__c' },
                { label: 'ProcessTime', fieldName: 'ProcessTime__c' },
                { label: 'FailedJobs', fieldName: 'FailedJobs__c' }
            ]);

            var actionObj = component.get("c.retrieveCustomObjectData");
            actionObj.setCallback(this, function (response) {
                var state = response.getState();
                console.log('__________state___________', state);
                if (state === "SUCCESS") {
                    var allValues = response.getReturnValue();
                    console.log("allObjectsValues---------------- ", allValues);
                    component.set("v.allObjectsValues", allValues);
                    console.log('______________component.get_______________', component.get("v.allObjectsValues"));
                }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        console.log("Error Message: " + errors);
                    }
                }
            });
            $A.enqueueAction(actionObj);
        } catch (error) {
            console.log('_______________error________________', error);

        }
    },

    searchKeyChange: function (component, event) {
        try {
            var selectedVal = event.target.value;
            component.set("v.selectedVal", selectedVal);
            console.log('_____________selectedVal_______________', component.get("v.selectedVal"));

        } catch (error) {
            console.log('___________searchKeyChangeError____________', error);
        }
    },
    handleClick: function (component, event) {
        try {
            var action = component.get("c.searchingAllObjects");
            action.setParams({
                "label": component.get("v.selectedVal")
            });
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Success!",
                "message": "The record has been deleted successfully.",
                "type": "Success"
            });
            toastEvent.fire();
            // $A.get('e.force:refreshView').fire();
            $A.enqueueAction(action);
        } catch (error) {
            console.log('_____________handleClickError________________', error);
        }
    }

})