({
    validateUser : function(component, event, helper) {
        
        helper.getUserProfileName(component, event, helper);
        
    },
    handleSubmit : function(cmp, event, helper) {
        var oldRecord = cmp.get('v.oldRecord');
        event.preventDefault();       // stop the form from submitting
        const fields = event.getParam('fields');
        if(cmp.get("v.isSalesOpsProfile") && fields.Quantity != oldRecord.Quantity || fields.UnitPrice != oldRecord.UnitPrice)
        {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error',
                message:'Sales Ops can only allowed to edit Launch Status and Launch Date fields.',
                duration:' 1000',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire(); 
            return;
        }
        cmp.find('myRecordForm').submit(fields);
    },
    handleSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'success',
            message:'Opportunity Product updated successfully',
            type: 'success',
        });
        toastEvent.fire();
        
        component.find("navigation")
        .navigate({
            "type" : "standard__recordPage",
            "attributes": {
                "recordId"      :  component.get("v.recordId"),
                "actionName"    : "view"   
            }
        }, true);
        
    },
})