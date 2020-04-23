 
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

END CLASS.