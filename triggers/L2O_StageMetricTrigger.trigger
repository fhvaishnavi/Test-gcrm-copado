trigger L2O_StageMetricTrigger on L2O_Stage_Metric__c (before insert,before update) {
     //Run Metadata Trigger Handler Class
    new SDF_TGF_MetadataTriggerHandler().run();   
}