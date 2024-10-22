/**
 * @Name        :   AccountAccountRelationshipTriggerHandler
 * @Description :   Trigger Handler class for AccountAccountRelationshipTrigger.
 * @Since       :   18th Oct, 2024
 * @TestClass   :   AccountAccountRelationshipTrigger_Test
 * @Author      :   Gopesh Banker (PWC)
 * 
 * Revision History
 * 
 * @Author      :   Author Name
 * @Description :   Sample Description
 */
public class AccountAccountRelationshipTriggerHandler{

    public static BOolean isFirstTime = true;

/**
 * @MethodName  :   beforeDelete
 * @Paramters   :   Trigger.old context variable from Handler class
 * @Description :   called for the before delete logic from Trigger
 * @ReturnType  :   Void
 * @Since       :   18th Oct, 2024
 */
    public static void beforeDelete(List<AccountAccountRelation> oldList) {
        if(isFirstTime)
        {
            isFirstTime = false;
            try{
                AccountAccountRelationshipTriggerHelper.deleteRelatedInverseAAR(oldList);
            }
            catch(Exception ex){
                system.debug('Exception'+ex.getLineNumber()+ex.getMessage());
            }
        }
    }
}