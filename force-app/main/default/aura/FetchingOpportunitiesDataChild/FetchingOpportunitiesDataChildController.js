({
    doInit: function (component, event, helper) {

    },

    ApplicationEventHandle: function (Component, event, helper) {
        var final = 0;
        var accountId = event.getParam("oppId");
        //console.log(' accId inside child', accountId);
        var action = Component.get("c.retrieveOpportunitiesRelatedToAccount");
        action.setParams({
            accId: accountId
        });
        action.setCallback(this, function (response) {
            var responseValue = response.getReturnValue();
            console.log(':::::', responseValue, '::::', response.getState());
            if (response.getState() === "SUCCESS") {
                Component.set("v.opportunityList", responseValue);
                console.log('____________Component.set______________', Component.get("v.opportunityList"));
                var arrayVal = [];
                arrayVal = Component.get("v.opportunityList");
                // console.log('++++++++++++++++++++++++', arrayVal[0].ExpectedRevenue);
                for (let index = 0; index < arrayVal.length; index++) {
                    console.log('___________arrayVal_____________', arrayVal[index].ExpectedRevenue);
                    final += arrayVal[index].ExpectedRevenue;
                }
                console.log('_____________final__________________', final);
                Component.set("v.revenueFinalValue", final)

                var compEvent = Component.getEvent("ComponentEvent");
                compEvent.setParams({ "revenue": final });
                compEvent.fire();
                console.log('event fired');
                // compEvent.set({"revenueFinalValue": final });
                // Component.Set("v.revenueFinalValue",final);
                //console.log('______________revenueFinalValueComponent________________',Component.setParams({ "revenueFinalValue": revenue }));
                // console.log('______________revenueFinalValue_________________', compEvent.get("revenueFinalValue")); 
            }
        });
        $A.enqueueAction(action);
        //console.log('@@@@@ ',Component.get("v.final"));
        // console.log('after method call::', Component.get("v.revenueFinalValue"));
    },
    changeToggle: function (cmp, event) {

        var indexVal = 0;
        if (event.target.checked === true) {
            indexVal = event.target.dataset.revenue;
            // console.log('_____________index if  indexVal_______________', Component.get("v.revenueFinalValue"));
            console.log('_____________values to add_______________', indexVal);
            var newFinalVal = cmp.get("v.revenueFinalValue");
            newFinalVal = parseInt(newFinalVal) + parseInt(indexVal);
            console.log('::::::::: final addition value:::::::::::::::', newFinalVal);
            cmp.set("v.revenueFinalValue", newFinalVal);
            console.log('____________after Addition______________', cmp.get("v.revenueFinalValue"));
        }

        else {
            indexVal = event.target.dataset.revenue;
            // console.log('_____________index else  indexVal_______________', Component.get("v.revenueFinalValue"));
            console.log('_____________values to substract_______________', indexVal);
            var newFinalVal = cmp.get("v.revenueFinalValue");
            newFinalVal = parseInt(newFinalVal) - parseInt(indexVal);
            console.log('::::::::: final substrcat value:::::::::::::::', newFinalVal);
            cmp.set("v.revenueFinalValue", newFinalVal);
            console.log('____________after substraction____________', cmp.get("v.revenueFinalValue"));
        }

        console.log('_______________2nd ComponentEvent____________');
        var cmpEvent = cmp.getEvent("ComponentEvent");
        cmpEvent.setParams({"revenue": cmp.get("v.revenueFinalValue")});
        cmpEvent.fire();
        console.log('event fired');

        // console.log('changeToggle');
        // var compEvent = cmp.getEvent("ComponentEvent");
        // compEvent.setParams({"toggleVal": indexVal});
        // compEvent.fire();
        // console.log('event fired');
    }

})