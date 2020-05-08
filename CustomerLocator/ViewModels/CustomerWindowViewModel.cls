 
/*------------------------------------------------------------------------
   File        : CustomerWindowViewModel
   Purpose     : 
   Syntax      : 
   Description : This ViewModel will keep the state of the main form.
   Author(s)   : nvasilev
   Created     : Thu Apr 23 11:19:42 EEST 2020
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING System.Data.* FROM ASSEMBLY.
USING Service.ServiceClient FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS ViewModels.CustomerWindowViewModel: 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    
    
    DEFINE VARIABLE oSportsDataServiceClient AS Service.ServiceClient NO-UNDO.
    
    DEFINE PUBLIC PROPERTY CustomerAddress AS CHARACTER NO-UNDO 
        GET:
            DEFINE VARIABLE address AS CHARACTER NO-UNDO.
            
            IF THIS-OBJECT:SelectedDataRow NE ? THEN DO:
                address = STRING(THIS-OBJECT:SelectedDataRow["City"]) + 
                    ", " + 
                    STRING(THIS-OBJECT:SelectedDataRow["Address"]) + 
                    " " + 
                    STRING(THIS-OBJECT:SelectedDataRow["Address2"]) +
                    ", "               
                    .
                
                IF (THIS-OBJECT:SelectedDataRow["State"] NE ?)  AND (STRING(THIS-OBJECT:SelectedDataRow["State"]) NE "") THEN DO:
                    address = address + 
                        STRING(THIS-OBJECT:SelectedDataRow["State"]).
                END.
                
                address = address + 
                    STRING(THIS-OBJECT:SelectedDataRow["Country"]).
            END.
            
            RETURN address.
        END GET.
    
    DEFINE PUBLIC PROPERTY SelectedDataRow AS DataRowView NO-UNDO 
        GET.
        SET.

    DEFINE PUBLIC PROPERTY CustomersDataTable AS DataTable NO-UNDO 
        GET.
        SET.

    CONSTRUCTOR PUBLIC CustomerWindowViewModel (  ):
        SUPER ().
        
        THIS-OBJECT:oSportsDataServiceClient = NEW ServiceClient("Production").
        
    END CONSTRUCTOR.
    
    METHOD PUBLIC VOID RefreshCustomers():
      
        ASSIGN THIS-OBJECT:CustomersDataTable = THIS-OBJECT:oSportsDataServiceClient:GetCustomers().
  
    END METHOD.
    
    METHOD PUBLIC VOID SaveSelectedCustomer():
      THIS-OBJECT:oSportsDataServiceClient:SaveCustomer(THIS-OBJECT:SelectedDataRow).
        
    END METHOD.

END CLASS.