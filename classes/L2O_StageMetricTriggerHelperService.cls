/**
* Company : Teladoc.
* @description : L2O_StageMetricTriggerHelperService will be executed from the L2O_StageMetricTriggerHandler and will update Business Hours field on Stage Metric
* *****************************************************************************************************************************************
* History : 
* @date 05/23/2024
* @author Sachin Pawar
*/
public without sharing class L2O_StageMetricTriggerHelperService {
    public void setBusinessHours() {
        List<L2O_Stage_Metric__c> listStageMetrics = Trigger.new;
        //Selecting default business hours (BH) record Business_Hours
        BusinessHours defaultBH = [SELECT Id FROM BusinessHours WHERE IsDefault = true Limit 1];
        //Making sure BH record exists
        if(defaultBH != NULL && listStageMetrics!=null){
            for(L2O_Stage_Metric__c stageObj : listStageMetrics ){
                String RecordTypeId = Schema.SObjectType.L2O_Stage_Metric__c.getRecordTypeInfosByName().get('Agreement').getRecordTypeId();
                //Making sure that Stage date field is populated and is updated
                if(stageObj.L2O_From_Stage_Date__c != NULL && stageObj.L2O_To_Stage__c != NULL && stageObj.RecordTypeId ==RecordTypeId ){
                    Datetime  toDate = (stageObj.L2O_Current_Stage_Date__c==null) ? DateTime.now() :stageObj.L2O_Current_Stage_Date__c;
                    //For BH method we assign (BH record id, start time field, end time field)
                    Decimal result = BusinessHours.diff(defaultBH.Id,  stageObj.L2O_From_Stage_Date__c,toDate );
                   //Result from the method is divided by 60*60*100 (milliseconds to be then converted into hours)
                    Decimal resultingHours = result/(60*60*1000);
                    //Populating result into our custom field & setting number of decimals
                    stageObj.Business_Hours__c = resultingHours.setScale(2); 
                }  
            }    
        }
    }
}