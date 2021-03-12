
 /*------------------------------------------------------------------------
    File        : Customer
    Purpose     :
    Syntax      : 
    Description :
    Author(s)   : nvasilev
    Created     : Mon Apr 20 12:18:35 EEST 2020
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="CustNum").
    
define temp-table ttCustomer before-table bttCustomer
field CustNum as integer initial "0" label "Cust Num"
field Country as character initial "USA" label "Country"
field Name as character label "Name"
field Address as character label "Address"
field Address2 as character label "Address2"
field City as character label "City"
field State as character label "State"
field PostalCode as character label "Postal Code"
field Contact as character label "Contact"
field Phone as character label "Phone"
field SalesRep as character label "Sales Rep"
field CreditLimit as decimal initial "1500" label "Credit Limit"
field Balance as decimal initial "0" label "Balance"
field Terms as character initial "Net30" label "Terms"
field Discount as integer initial "0" label "Discount"
field Comments as character label "Comments"
field Fax as character label "Fax"
field EmailAddress as character label "Email"
field StringId as character label "StringId"
index Comments  Comments  ascending 
index CountryPost  Country  ascending  PostalCode  ascending 
index CustNum is  primary  unique  CustNum  ascending 
index Name  Name  ascending 
index SalesRep  SalesRep  ascending . 


define dataset dsCustomer for ttCustomer.