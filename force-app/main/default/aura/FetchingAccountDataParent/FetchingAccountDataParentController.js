({
    doinit: function (component, event, helper) {
        var action = component.get('c.fetchAccounts');
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var allValues = response.getReturnValue();
                console.log("allValues--->>> " + allValues);
                component.set('v.accData', allValues);
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
    },

    handleOppo: function (component, event, helper) {
        console.log('handle changed');
        helper.helperGetOpportunity(component, event, helper);
        // console.log('########');
        // console.log('::::::::',component.get("v.accountId"));

        var appEvent = $A.get("e.c:ApplicationEventForOpportunitiesId");
        //Set event attribute value
        appEvent.setParams({ "oppId": component.get("v.accountId") });
        appEvent.fire();
    },
    handleComponentEvent: function (Component, event, helper) {
        console.log(':::inside handleComponentEvent');
        var valueFromChild = event.getParam("revenue");

        var togglevalueFromChild = event.getParam("toggleVal");

        Component.set("v.totalRev", valueFromChild);
        
        console.log('____________toggleEventinParent__________________', togglevalueFromChild);
        console.log('cmp Event value in parent :::',valueFromChild);
    }
})