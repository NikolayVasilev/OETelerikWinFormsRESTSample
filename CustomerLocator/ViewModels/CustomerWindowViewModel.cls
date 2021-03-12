 
/*------------------------------------------------------------------------
   File        : CustomerWindowViewModel
   Purpose     : 
   Syntax      : 
   Description : This ViewModel will keep the state of the main form.
   Author(s)   : nvasilev
   Created     : Thu Apr 23 11:19:42 EEST 2020
   Notes       : 
 ----------------------------------------------------------------------*/

using Progress.Lang.*.
using System.Data.* from assembly.
using Service.ServiceClient from propath.

block-level on error undo, throw.

class ViewModels.CustomerWindowViewModel: 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    
    
    define variable oSportsDataServiceClient as Service.ServiceClient no-undo.
    
    define public property CustomerAddress as character no-undo 
        get:
            define variable address as character no-undo.
            
            if this-object:SelectedDataRow ne ? then do:
                address = string(this-object:SelectedDataRow["City"]) + 
                    ", " + 
                    STRING(this-object:SelectedDataRow["Address"]) + 
                    " " + 
                    STRING(this-object:SelectedDataRow["Address2"]) +
                    ", "               
                    .
                
                if (this-object:SelectedDataRow["State"] ne ?)  and (string(this-object:SelectedDataRow["State"]) ne "") then do:
                    address = address + 
                        STRING(this-object:SelectedDataRow["State"]).
                end.
                
                address = address + 
                    STRING(this-object:SelectedDataRow["Country"]).
            end.
            
            return address.
        end get.
    
    define public property SelectedDataRow as DataRowView no-undo 
        get.
        set.

    define public property CustomersDataTable as DataTable no-undo 
        get.
        private set.

    constructor public CustomerWindowViewModel (  ):
        super ().
        
        this-object:oSportsDataServiceClient = new ServiceClient("Production").
        
    end constructor.
    
    method public void RefreshCustomers():
      
        assign this-object:CustomersDataTable = this-object:oSportsDataServiceClient:GetCustomers().
  
    end method.
    
    method public void SaveSelectedCustomer():
      this-object:oSportsDataServiceClient:SaveCustomer(this-object:SelectedDataRow).
        
    end method.

end class.