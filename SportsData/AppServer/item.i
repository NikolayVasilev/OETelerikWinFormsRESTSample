
 /*------------------------------------------------------------------------
    File        : Item
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : nvasilev
    Created     : Thu Apr 23 09:49:24 EEST 2020
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="ItemNum").
	
DEFINE TEMP-TABLE ttItem NO-UNDO BEFORE-TABLE bttItem
FIELD ItemNum AS INTEGER INITIAL "0" LABEL "Item Num"
FIELD ItemName AS CHARACTER LABEL "Item Name"
FIELD Price AS DECIMAL INITIAL "0" LABEL "Price"
FIELD OnHand AS INTEGER INITIAL "0" LABEL "On Hand"
FIELD Allocated AS INTEGER INITIAL "0" LABEL "Allocated"
FIELD ReOrder AS INTEGER INITIAL "0" LABEL "Re Order"
FIELD OnOrder AS INTEGER INITIAL "0" LABEL "On Order"
FIELD CatPage AS INTEGER INITIAL "0" LABEL "Cat Page"
FIELD CatDescription AS CHARACTER LABEL "Cat-Description"
FIELD Category1 AS CHARACTER LABEL "Category1"
FIELD Category2 AS CHARACTER LABEL "Category2"
FIELD Special AS CHARACTER LABEL "Special"
FIELD Weight AS DECIMAL INITIAL "0" LABEL "Weight"
FIELD MinQty AS INTEGER INITIAL "0" LABEL "Min Qty"
FIELD ItemImage AS BLOB
INDEX CatDescription  CatDescription  ASCENDING 
INDEX Category2ItemName  Category2  ASCENDING  ItemName  ASCENDING 
INDEX CategoryItemName  Category1  ASCENDING  ItemName  ASCENDING 
INDEX ItemName  ItemName  ASCENDING 
INDEX ItemNum IS  PRIMARY  UNIQUE  ItemNum  ASCENDING . 


DEFINE DATASET dsItem FOR ttItem.