trigger AgreementLineItemTrigger on Apttus__AgreementLineItem__c (after insert, after delete) {

    BypassSetting__c byPassSetting = BypassSetting__c.getInstance(UserInfo.getProfileId());
    //If the user can bypass the trigger, return and do not continue the trigger.
    if(byPassSetting.Bypass_Trigger__c)
    {
        return;
    }
    ProductFamilyHandler.executeTrigger();   
}