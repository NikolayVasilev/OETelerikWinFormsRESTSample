 
 /*------------------------------------------------------------------------
    File        : Item
    Syntax      : 
    Author(s)   : Administrator
    Created     : Mon Nov 11 19:02:29 UTC 2019
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="Item.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="Item", URI="/Item", schemaName="dsItem", schemaFile="SportsData/AppServer/item.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Item INHERITS BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"item.i"}
    
    DEFINE DATA-SOURCE srcItem FOR sports2020.Item.
    
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC Item():
        
        DEFINE VARIABLE hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VARIABLE cSkipListArray AS CHARACTER NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsItem:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */     
         hDataSourceArray[1] =  DATA-SOURCE srcItem:HANDLE.
         
                  
         /* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
            ignored in create stmt */
             
         cSkipListArray[1] = "".
         
         
         THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
                 
    END CONSTRUCTOR.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadItem(
        INPUT filter AS CHARACTER, 
        OUTPUT DATASET dsItem):

        /* add this code for workshop*/
        DEFINE VARIABLE ltmpString AS CHARACTER NO-UNDO.
        EMPTY TEMP-TABLE ttItem NO-ERROR. 
    
    
        FOR EACH item NO-LOCK:
            CREATE ttitem.
            ASSIGN 
                ttItem.id          = item.itemnum
                ttItem.itemNum     = item.itemnum
                ttItem.name        = item.itemName
                ttItem.price       = item.Price
                ttItem.category    = item.Category1    
                ttItem.description = item.CatDescription
                ttItem.weight      = item.weight
                ttItem.onHand      = item.Onhand 
                ltmpstring         = REPLACE(Item.ItemName, ' ', '') + ".jpg"  
                ttItem.image       = ltmpstring.
        
        END.
    /* end of code add for workshop */  
    END METHOD. 
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreateItem(INPUT-OUTPUT DATASET dsItem):            
               
        SUPER:CreateData(DATASET dsItem BY-REFERENCE).        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdateItem(INPUT-OUTPUT DATASET dsItem):            
    
        SUPER:UpdateData(DATASET dsItem BY-REFERENCE).          
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeleteItem(INPUT-OUTPUT DATASET dsItem):                    
    
        SUPER:DeleteData(DATASET dsItem BY-REFERENCE).
    END METHOD.
     
    
END CLASS.
