 
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

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS ViewModels.CustomerWindowViewModel: 

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    CONSTRUCTOR PUBLIC CustomerWindowViewModel (  ):
        SUPER ().
        
    END CONSTRUCTOR.

END CLASS.