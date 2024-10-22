/**
 * @Name        :   AccountAccountRelationshipTriggerHelper
 * @Description :   Helper class for AccountAccountRelationshipTrigger.
 * @Since       :   18th Oct, 2024
 * @TestClass   :   AccountAccountRelationshipTrigger_Test
 * @Author      :   Gopesh Banker (PWC)
 * 
 * Revision History
 * 
 * @Author      :   Author Name
 * @Description :   Sample Description
 */
public without sharing class AccountAccountRelationshipTriggerHelper {
    
    //Exception log variables
    public static String className = '';
    public static String methodName = '';

/**
 * @MethodName  :   deleteRelatedInverseAAR
 * @Paramters   :   Trigger.old context variable from Handler class
 * @Description :   deletes the related inverse account account relationship record (if exists) while deleting the current record.
 * @ReturnType  :   Void
 * @Since       :   18th Oct, 2024
 */
    public static void deleteRelatedInverseAAR(List<AccountAccountRelation> oldList)
    {
        System.debug('In deleteRelatedInverseAAR');
        Set<Id> setInverseAARID = new Set<Id>();
        Set<Id> setPartyRoleRelationId = new Set<Id>();
        List<AccountAccountRelation> listAARToUpdate = new List<AccountAccountRelation>();
        for(AccountAccountRelation objAAR : oldList)
        {
            setInverseAARId.add(objAAR.RelatedInverseRecordId);
            setPartyRoleRelationId.add(objAAR.PartyRoleRelationId);
        }

        List<AccountAccountRelation> listInverseAAR = [Select Id from AccountAccountRelation Where Id in :setInverseAARID];
        if(!listInverseAAR.isEmpty())
        {
            delete listInverseAAR;
        }
    }
}