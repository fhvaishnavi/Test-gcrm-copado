/**
* Company : Teladoc.
* @description : L2O_StageMetricTriggerHandler will be executed from the L2O_StageMetricTrigger and will extend the SDF_TGF_TriggerHandler.
* ************************************************************************************************************************************
* History : 
* @date 05/23/2024
* @author Sachin Pawar
*/
public class L2O_StageMetricTriggerHandler extends SDF_TGF_TriggerHandler{
    //Exception log variables
    public static String className = 'L2O_StageMetricTriggerHandler';
    public static String methodName = '';
    
     	/**
	* @name  beforeInsert
	* @description To override beforeInsert
	* @params  none
	**/
    public override void beforeInsert() {
        try{
             L2O_StageMetricTriggerHelperService helper = new L2O_StageMetricTriggerHelperService();   
             helper.setBusinessHours();
        }
        catch(Exception ex){
            SDF_LGR_LoggerManager.DBufLogger.error(ex,className,methodName);
        }
        finally{
            SDF_LGR_LoggerManager.DBufLogger.flush();
        }
        
    }
    
    public override void beforeUpdate() {
        try{
            L2O_StageMetricTriggerHelperService helper = new L2O_StageMetricTriggerHelperService();   
            helper.setBusinessHours();
        }
        catch(Exception ex){
            SDF_LGR_LoggerManager.DBufLogger.error(ex,className,methodName);
        }
        finally{
            SDF_LGR_LoggerManager.DBufLogger.flush();
        }
    }
}