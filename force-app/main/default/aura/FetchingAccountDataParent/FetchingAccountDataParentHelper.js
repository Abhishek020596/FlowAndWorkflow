({
    helperGetOpportunity: function (component, event, Helper) {
        console.log('inside helper');
        var opid = component.find('ac').get('v.value');
        //console.log('________________opid__________________',opid);
        component.set("v.accountId",opid);
        //console.log('________________opid__________________',component.get("v.accountId"));

        // var action = component.get('c.getopportunity');

        // action.setParams({
        //     accid: opid
        // });
        // action.setCallback(this, function (response) {
        //     console.log('opp response==>  ' + JSON.stringify(response.getReturnValue()));
        //     if (response.getReturnValue() != null) {
        //         console.log("OPP success");
        //         component.set('v.opportunityList', response.getReturnValue());
        //         console.log("Pass");
        //     }
        // });
        // $A.enqueueAction(action);
    }
})