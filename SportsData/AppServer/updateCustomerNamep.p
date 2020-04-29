
/*------------------------------------------------------------------------
    File        : updateCustomerNamep
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : nvasilev
    Created     : Mon Apr 27 12:41:03 EEST 2020
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

FOR FIRST Customer:
    ASSIGN Customer.Name = Customer.Name + "1".
    // ASSIGN Customer.Name = "LiftTours".
END.