
 /*------------------------------------------------------------------------
    File        : Item
    Purpose     :
    Syntax      : 
    Description :
    Author(s)   : Administrator
    Created     : Mon Nov 04 12:44:17 UTC 2019
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="ItemNum").
    
DEFINE TEMP-TABLE ttItem BEFORE-TABLE bttItem
FIELD id          AS INTEGER   INITIAL "0"  
FIELD itemNum     AS INTEGER   INITIAL "0"  
FIELD name        AS CHARACTER   
FIELD price       AS DECIMAL
FIELD image       AS CHARACTER 
FIELD category    AS CHARACTER 
FIELD description AS CHARACTER
FIELD featured    AS LOGICAL   INITIAL TRUE
FIELD onHand      AS INTEGER
FIELD weight      AS DECIMAL
INDEX id IS  PRIMARY  UNIQUE  id  DESCENDING . 

DEFINE DATASET dsItem FOR ttItem.