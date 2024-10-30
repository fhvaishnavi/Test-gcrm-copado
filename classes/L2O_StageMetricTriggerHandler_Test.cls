/**
* Company : Teladoc.
* @description : Test Class for L2O_StageMetricTriggerHandler apex
* ************************************************************************************************************************************
* History : 
* @date 05/23/2024
* @author Sachin Pawar
*/

@istest
public class L2O_StageMetricTriggerHandler_Test {
    /**
* @name  testcatchException()
* @description Tests L2O_StageMetricTriggerHandler class catch block
* @params  none
*/
    @istest
    public static void testcatchException() {
        Test.startTest();
        L2O_StageMetricTriggerHandler helper = new L2O_StageMetricTriggerHandler();
        helper.beforeInsert();
        helper.beforeUpdate();
        Test.stopTest();       
    }
    /**
* @name  testsetGUID()
* @description Tests Stage metric record creation on agreement stage Update
* @params  none
*/
    @istest
    public static void testAgreementStageMetrics() {
        list<Account> accList= L2O_DataFactoryTest.createAccount(true,1);
        Apttus__APTS_Agreement__c tempAgreement = new Apttus__APTS_Agreement__c(Name = 'Test', Apttus__Account__c = accList[0].Id);
        Test.startTest();
        tempAgreement.Apttus__Status_Category__c = 'In Authoring';
        insert tempAgreement;
        Test.stopTest();
        tempAgreement.Apttus__Status__c = 'Author Contract';
        Update tempAgreement;
        tempAgreement.Apttus__Status__c = 'Language Approval';
        Update tempAgreement;
        List<L2O_Stage_Metric__c> lstStageMetrics = [SELECT Id,Name,Agreement__c, L2O_To_Stage__c, L2O_From_Stage__c FROM L2O_Stage_Metric__c ];
        System.assertEquals(2,lstStageMetrics.Size(),'Creation Test Successful');
    }
    
}