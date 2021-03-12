 
/*------------------------------------------------------------------------
   File        : Customer
   Syntax      : 
   Author(s)   : nvasilev
   Created     : Mon Apr 20 12:18:35 EEST 2020
   Notes       : 
 ----------------------------------------------------------------------*/
  
@program FILE(name="Customer.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="Customer", URI="/Customer", schemaName="dsCustomer", schemaFile="SportsData/AppServer/customer.i").

using Progress.Lang.*.
using OpenEdge.BusinessLogic.BusinessEntity.

block-level on error undo, throw.

class Customer inherits BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"customer.i"}
    
    define data-source srcCustomer for sports2020.Customer.
    
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    constructor public Customer():
        
        define variable hDataSourceArray as handle no-undo extent 1.
        define variable cSkipListArray as character no-undo extent 1.
        
        super (dataset dsCustomer:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */     
        hDataSourceArray[1] =  data-source srcCustomer:HANDLE.
         
                  
        /* Skip-list entry for each table in dataset. Should be in temp-table order 
          as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
            ignored in create stmt */
             
        cSkipListArray[1] = "".
         
         
        this-object:ProDataSource = hDataSourceArray.
        this-object:SkipList = cSkipListArray.
                 
    end constructor.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    method public void ReadCustomer(
        input filter as character, 
        output DATASET dsCustomer):
        
        super:ReadData(filter).
              
    end method.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    method public void CreateCustomer(input-output DATASET dsCustomer):            
               
        super:CreateData(DATASET dsCustomer by-reference).        
    end method.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    method public void UpdateCustomer(input-output DATASET dsCustomer):            
    
        if available(ttCustomer) then do:
            for each ttCustomer:
                ttCustomer.Comments = "Updated by server on: " + string(now).
            end.
        end.
        
        super:UpdateData(DATASET dsCustomer by-reference).          
    end method.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    method public void DeleteCustomer(input-output DATASET dsCustomer):                    
    
        super:DeleteData(DATASET dsCustomer by-reference).
    end method.
     
    
end class.
